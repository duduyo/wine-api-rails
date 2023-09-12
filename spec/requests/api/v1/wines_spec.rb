require 'swagger_helper'

RSpec.describe 'api/v1/wines', type: :request do

  before do
      # We do not use fixtures because there creation skips the callbacks
      @vin_de_pays = Wine.create(name: "Vin de pays", price_euros: 9.99, store_url: "https://www.store1.com")
      @beaujolais = Wine.create(name: "Beaujolais", price_euros: 10, store_url: "https://www.store2.com")
      @bourgogne = Wine.create(name: "Bourgogne", price_euros: 30, store_url: "https://www.store2.com")
      @chateau_petrus = Wine.create(name: "Château Petrus", price_euros: 2599.99, store_url: "https://www.store2.com")

      @beaujolais.reviews.create(note: 1, comment: "This is a comment")
      @beaujolais.reviews.create(note: 2, comment: "This is a comment")
      @bourgogne.reviews.create(note: 4.9, comment: "This is a comment")
  end

  wine_spec = {
    type: :object,
    properties: {
      id: { type: :integer },
      name: { type: :string },
      price_euros: { type: :number },
      store_url: { type: :string },
      note: { type: :number, nullable: true },
      created_at: { type: :string },
      updated_at: { type: :string },
    },
    required: ['id', 'name', 'price_euros', 'store_url', 'created_at', 'updated_at']
  }
  wine_detail_spec = {
    type: :object,
    properties: {
      id: { type: :integer },
      name: { type: :string },
      price_euros: { type: :number },
      store_url: { type: :string },
      note: { type: :number, nullable: true },
      created_at: { type: :string },
      updated_at: { type: :string },
      reviews: {
        type: :array,
        items: {
          type: :object,
          properties: {
            id: { type: :integer },
            wine_id: { type: :integer },
            comment: { type: :string },
            note: { type: :number },
            created_at: { type: :string },
            updated_at: { type: :string }
          }
        }
      }
    },
    required: ['id', 'name', 'price_euros', 'store_url', 'created_at', 'updated_at']
  }

  path '/api/v1/wines' do
    get 'Retrieves all wines, filtered by min_price and max_price if provided, and ordered by note (descending)' do
      tags 'Users API', 'Experts API', 'Admin API'
      parameter name: 'min_price', in: :query, type: :integer, description: 'Minimum price', required: false
      parameter name: 'max_price', in: :query, type: :integer, description: 'Maximum price', required: false
      produces 'application/json', 'application/xml'
      response('200', 'OK') do
        schema type: :array,
                items: wine_spec

        let(:min_price) { '10' }
        let(:max_price) { '30' }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data.length).to eq(2)
          expect(data[0]['name']).to eq('Bourgogne')
          expect(data[0]['note']).to eq(4.9)
          expect(data[1]['name']).to eq('Beaujolais')
          expect(data[1]['note']).to eq(1.5)
        end
      end
    end

    post 'Add a wine' do
      tags 'Admin API'
      consumes 'application/json'
      parameter name: :wine, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          price_euros: { type: :number },
          store_url: { type: :string },
        },
        required: ['name', 'price_euros', 'store_url']
      }

      response '201', 'Review created' do
        let(:wine) { { name: 'Wine name', price_euros: 10, store_url: 'https://www.store.com' } }
        run_test!
      end
    end


  end


  path '/api/v1/wines/{wine_id}' do
    get 'Get the details of a wine' do
      tags 'Users API', 'Experts API'
      consumes 'application/json'
      parameter name: :wine_id, in: :path, type: :integer, description: 'Wine id', required: true
      response '200', 'OK' do
        let(:wine_id) { @beaujolais.id }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['name']).to eq('Beaujolais')
        end
      end
    end
  end

  path '/api/v1/wines/{wine_id}/reviews' do
    post 'Add a review to a wine' do
      tags 'Experts API'
      consumes 'application/json'
      parameter name: :wine_id, in: :path, type: :integer, description: 'Wine id', required: true
      parameter name: :review, in: :body, schema: {
        type: :object,
        properties: {
          note: { type: :number },
          comment: { type: :string }
        },
        required: [ 'note', 'coment' ]
      }

      response '201', 'Review created' do
        let(:wine_id) { @beaujolais.id }
        let(:review) { { note: 1, comment: 'No comment' } }
        run_test!
      end
    end
  end

end

require 'swagger_helper'

RSpec.describe 'api/v1/searches', type: :request do

  before do
    # We do not use fixtures because there creation skips the callbacks
    Search.create(min_price: 10, max_price: 30)
    Search.create(min_price: 50, max_price: 100, notification_email: 'user@mail.org')
  end

  searches_spec = {
    type: :object,
    properties: {
      id: { type: :integer },
      min_price: { type: :number, nullable: true },
      max_price: { type: :number, nullable: true },
      notification_email: { type: :string, nullable: true },
      created_at: { type: :string },
      updated_at: { type: :string },
    }
  }


  path '/api/v1/searches' do
    post 'Save a search' do
      tags 'Searches'
      consumes 'application/json'
      parameter name: :search, in: :body, schema: searches_spec

      response '201', 'Review created' do
        let(:search) { { max_price: 30, notification_email: 'user@mail.org' } }
        run_test!
      end

    end
  end

  path '/api/v1/searches' do
    get 'Retrieves all searches' do
      tags 'Searches'
      produces 'application/json', 'application/xml'
      response('200', 'OK') do
        schema type: :array,
                items: searches_spec

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data.length).to eq(2)
          expect(data[1]['min_price']).to eq(50)
          expect(data[1]['max_price']).to eq(100)
          expect(data[1]['notification_email']).to eq('user@mail.org')
        end
      end
    end
  end



end

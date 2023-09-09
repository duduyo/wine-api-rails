require 'swagger_helper'

RSpec.describe 'api/v1/wines', type: :request do

  wine_spec = {
    type: :object,
    properties: {
      id: { type: :integer },
      name: { type: :string },
      price_euros: { type: :number },
      store_url: { type: :string },
      note: { type: :number },
      created_at: { type: :string },
      updated_at: { type: :string }
    },
    required: ['id', 'name', 'price_euros', 'store_url', 'created_at', 'updated_at']
  }

  path '/api/v1/wines' do
    get 'Retrieves all wines' do
      tags 'Wines'
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
          expect(data[0]['name']).to eq('Beaujolais')
          expect(data[0]['name']).to eq('Bourgogne')
        end
      end
    end
  end

end

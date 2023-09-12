require 'swagger_helper'

RSpec.describe 'api/v1/searches', type: :request do

  searches_spec = {
    type: :object,
    properties: {
      min_price: { type: :number },
      max_price: { type: :number },
      notification_email: { type: :string },
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
          expect(data.length).to eq(1)
          expect(data[0]['max_price']).to eq(10)
          expect(data[0]['notification_email']).to eq('user@mail.org')
        end
      end
    end
  end



end

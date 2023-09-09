require 'swagger_helper'

RSpec.describe 'api/v1/wines', type: :request do

  path '/api/v1/wines' do

    get 'Retrieves all wines' do
      # tags 'Wines', 'Another Tag'
      produces 'application/json', 'application/xml'
      # parameter name: :id, in: :path, type: :string

      response('200', 'OK') do
        schema type: :array,
                items: {
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
                  required: [ 'id', 'name', 'price_euros', 'store_url', 'created_at', 'updated_at' ]
                }
        let(:id) { Blog.create(title: 'foo', content: 'bar').id }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data.length).to eq(2)
          expect(data[0]['name']).to eq('Château 2')
        end
      end
    end

  end






  # path '/api/v1/wines/{id}' do
  #   # You'll want to customize the parameter types...
  #   parameter name: 'id', in: :path, type: :string, description: 'id'
  #
  #   get('show wine') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }
  #
  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
  #
  #   patch('update wine') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }
  #
  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
  #
  #   put('update wine') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }
  #
  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
  #
  #   delete('delete wine') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }
  #
  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
  # end
end

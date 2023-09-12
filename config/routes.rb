Rails.application.routes.draw do
  resources :searches
  mount Rswag::Ui::Engine => '/'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      resources :wines, only: [:index, :show, :create] do
        post 'reviews', on: :member, to: 'wines#add_review'
      end
      resources :searches, only: [:index, :create]
    end
  end

end

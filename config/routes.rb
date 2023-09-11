Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      resources :wines do
        post 'reviews', on: :member, to: 'wines#add_review'
      end
    end
  end

end

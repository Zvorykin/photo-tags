Rails.application.routes.draw do
  devise_for :users

  root to: 'login#index'

  namespace 'login' do
    get 'index'
    get 'auth'
    post 'create'
  end

  scope 'api' do
    scope 'v1' do
      resources :tags
      resources :photos
    end
  end

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
end

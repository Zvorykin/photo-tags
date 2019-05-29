Rails.application.routes.draw do
  devise_for :users

  root to: 'login#index'

  namespace 'login' do
    get 'index'
    get 'auth'
  end

  scope 'api', defaults: { format: :json } do
    scope 'v1' do
      resources :hits
      resources :tags
      resources :photos

      get 'balance', controller: 'tests'
    end

    mount Rswag::Ui::Engine => '/docs'
    mount Rswag::Api::Engine => '/docs'
  end
end

# frozen_string_literal: true

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

      get 'hits/:hit_id/assignments', to: 'hits#assignments'

      resources :tags
      resources :photos

      get 'balance', controller: 'accounts'
    end

    get 'question', to: 'question#show'

    mount Rswag::Ui::Engine => '/docs'
    mount Rswag::Api::Engine => '/docs'
  end
end

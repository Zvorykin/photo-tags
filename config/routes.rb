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
      put 'hits/:hit_id/assignments', to: 'hits#update_assignments'

      resources :tags
      resources :photos
      resources :assignments
      put 'assignments/:assignment_id/results', to: 'assignments#add_result'
      get 'assignments_to_review', to: 'assignments#review'

      get 'balance', controller: 'accounts'
      get 'question', to: 'question#show'
    end

    mount Rswag::Ui::Engine => '/docs'
    mount Rswag::Api::Engine => '/docs'
  end
end

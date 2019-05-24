Rails.application.routes.draw do
  root to: 'login#index'

  get 'login/index'
  get 'login/auth'
end

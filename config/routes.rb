Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks' }

  resources :questions do
    resources :answers, shallow: true, only: [:create, :update]
  end

  namespace :api do
    namespace :v1 do
      resources :profiles, only: [] do
        get :me, on: :collection
      end
    end
  end

  root to: 'questions#index'
end

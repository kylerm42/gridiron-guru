GridironGuru::Application.routes.draw do
  root to: 'site#root'

  resources :users, except: [:index, :destroy], param: :username do
    resource :session, only: :index
  end

  resources :leagues, only: [:index, :show, :create, :update, :destroy]

  namespace :api, defaults: { format: :json } do
    resources :teams, only: [:index, :show, :create, :update, :destroy]
    resources :add_drops, only: [:create]
    resources :players, only: [:index, :show]
    resources :trades, only: [:create, :update, :destroy]
    resources :roster_spots, only: [:index, :create, :update, :destroy]
    resources :matchups, only: [:show, :index]
  end

  resource :session, only: [:new, :create, :destroy]
end
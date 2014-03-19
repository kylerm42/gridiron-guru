FantasyFootball::Application.routes.draw do
  root to: 'site#root'

  resources :users, except: [:index, :destroy], param: :username do
    resource :session, only: :index
  end

  namespace :api, defaults: { format: :json } do
    get 'leagues/user', to: 'leagues#for_user'
    resources :leagues, only: [:index, :show, :create, :update, :destroy] do
      resources :teams, only: [:index, :show, :create, :update, :destroy]
      resources :add_drops, only: [:create]
    end
    resources :players, only: [:index, :show]
  end

  resource :session, only: [:new, :create, :destroy]
end
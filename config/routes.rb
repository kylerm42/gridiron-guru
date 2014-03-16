FantasyFootball::Application.routes.draw do
  root to: 'site#root'

  resources :users, except: [:index, :destroy], param: :username do
    resource :session, only: :index
  end

  namespace :api, defaults: { format: :json } do
    resources :leagues, only: [:index, :show, :create, :update, :destroy]
    get 'leagues/user', to: 'leagues#for_user'
    resources :teams, only: [:index, :show, :create, :update, :destroy]
    resources :players, only: [:index, :show]
  end

  resource :session, only: [:new, :create, :destroy]
end
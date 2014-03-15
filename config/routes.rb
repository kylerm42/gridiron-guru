FantasyFootball::Application.routes.draw do
  root to: 'site#root'

  resources :users, except: [:index, :destroy], param: :username do
    resource :session, only: :index
  end

  namespace :api do
    resources :leagues, only: [:create, :update, :destroy]
  end

  resource :session, only: [:new, :create, :destroy]
end
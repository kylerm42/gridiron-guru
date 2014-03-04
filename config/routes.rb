FantasyFootball::Application.routes.draw do
  root to: 'users#show'

  resources :users, except: [:index, :destroy], param: :username do
    resource :session, only: :index
  end

  resources :leagues do
    resources :teams, only: [:new, :create, :show]
    resources :messages, except: [:index, :show]
    resources :players, only: [:index, :show]
  end

  resources :teams, only: [:edit, :update, :destroy] do
    resources :team_players, only: [:new, :create, :destroy]
    resources :trades, only: [:index, :new, :create]
    resources :add_drops, only: [:index, :new, :create]
    resources :watched_players, except: [:index, :edit, :update]
  end

  resources :trades, only: [:show, :destroy] do
    resources :trade_players, only: [:create, :destroy]
    resources :messages, except: [:index, :show]
  end

  resources :add_drops, only: [:destroy] do
    resources :added_players, only: [:create, :destroy]
    resources :dropped_players, only: [:create, :destroy]
  end

  resource :session, only: [:new, :create, :destroy]
end
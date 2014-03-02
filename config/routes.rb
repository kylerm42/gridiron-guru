FantasyFootball::Application.routes.draw do
  root to: 'users#show'

  resources :users, except: [:index, :destroy] do
    resource :session, only: :index
  end

  resources :league do
    resources :teams, except: :index do
      resources :team_players, only: [:new, :create, :destroy]
      resources :trades, except: [:edit, :update] do
        resources :trade_players, only: [:new, :create, :destroy]
        resources :messages, except: [:index, :show]
      end
      resources :add_drops, except: [:index, :edit, :update] do
        resources :added_players, only: [:new, :create, :destroy]
        resources :dropped_players, only: [:new, :create, :destroy]
      end
      resources :watched_players, except: [:show, :edit, :update]
    end
    resources :messages, except: [:index, :show]
    resources :players, only: [:index, :show]
  end

  resource :session, only: [:new, :create, :destroy]
end
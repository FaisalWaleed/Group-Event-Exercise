Rails.application.routes.draw do
  resources :users do   
    resources :group_events do
      post :publish, on: :member 
    end
  end
  namespace :api do
    namespace :v1 do
      resources :users do   
        resources :group_events , only: [:create,:index]
      end
      resources :group_events , only: [:show, :update, :destroy] do
        post :publish, on: :member
      end
    end
  end
  root :to => "users#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Miletracker::Application.routes.draw do
  devise_for :users, 
  	:controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }

  namespace :api do
    api_version(module: 'v1', header: {name: 'API-VERSION', value: 'v1'}, 
                parameter: {name: 'version', value: 'v1'}, 
                path: {value: 'v1'}) do
      resources :locations, only: :none do
        collection do
          post :bulk_create 
        end
      end            
    end
  end
  
  root :to => 'home#index'
  get 'about' => 'home#about'
  get 'privacy' => 'home#privacy'
  get 'terms' => 'home#terms'
  get 'apps' => 'home#apps'
end

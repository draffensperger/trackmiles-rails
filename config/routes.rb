Miletracker::Application.routes.draw do
  devise_for :users, 
  	:controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  root :to => 'home#index' 

  namespace :api do
    api_version(module: 'v1', header: {name: 'API-VERSION', value: 'v1'}, 
                parameter: {name: "version", value: 'v1'}, 
                path: {value: 'v1'}) do
      resources :locations, only: :none do
        collection do
          post :bulk_create 
        end
      end            
    end
  end
end

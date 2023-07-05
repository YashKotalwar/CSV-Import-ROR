Rails.application.routes.draw do
  # resources :users do
  #   collection do
  #     post :import
  #   end
  # end

  namespace :api do
    namespace :v1 do
      resources :users do
        collection do
          post :import
        end
      end
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

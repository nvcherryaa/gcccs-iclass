Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users do
        collection do
          post :delete
          post :login
          post :edit_data
        end
      end
    end
  end

end

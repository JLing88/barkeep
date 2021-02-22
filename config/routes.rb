Rails.application.routes.draw do
  apipie
  namespace :api do
    namespace :v1 do
      resources :searches, only: [:index, :show, :destroy]
    end
  end
end

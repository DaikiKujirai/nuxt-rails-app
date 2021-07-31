Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index show]
      resources :posts, only: %i[index show create update destory]
    end
  end
end

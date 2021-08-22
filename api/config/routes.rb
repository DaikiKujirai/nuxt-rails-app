Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :posts, only: %i[index show create update destroy]
      resources :comments
      get 'search_comments/:id' => 'comments#search_comments'
    end
  end
end

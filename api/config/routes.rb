Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users do
        resource :relationships, only: [:create, :destroy]
        get :following, :followers
      end
      resources :posts, only: %i[index show create update destroy]
      resources :likes, only: %i[create destroy]
      # user
      get 'find_login_user/:uid' => 'users#find_login_user'
      # post
      get 'find_comments/:id'    => 'posts#find_comments'
    end
  end
end

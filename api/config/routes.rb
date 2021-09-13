Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :relationships, only: %i[create destroy]
        get :is_following
      end
      resources :posts     , only: %i[index show create update destroy]
      resources :likes     , only: %i[create destroy]
      resources :chat_rooms, only: %i[show]
      # user
      get 'find_login_user/:uid'     => 'users#find_login_user'
      get 'show_user_posts/:id'      => 'users#show_user_posts'
      get 'show_user_like_posts/:id' => 'users#show_user_like_posts'
      get 'show_user_comments/:id'   => 'users#show_user_comments'
      put 'update_account/:id'       => 'users#update_account'
      # post
      get 'find_comments/:id'        => 'posts#find_comments'
      # like
      get 'render_is_like_and_likes_count/:id' => 'likes#render_is_like_and_likes_count'
      # relationship
      get 'find_following/:id'       => 'relationships#find_following'
      get 'find_followers/:id'       => 'relationships#find_followers'
      # ActionCable
      # mount ActionCable.server       => '/cable'
    end
  end
end

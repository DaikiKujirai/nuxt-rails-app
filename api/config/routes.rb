Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :relationships, only: [:create, :destroy]
        get :is_following, :find_following_ids, :find_user_followers
      end
      resources :posts, only: %i[index show create update destroy]
      resources :likes, only: %i[create destroy]
      # user
      get 'find_login_user/:uid'     => 'users#find_login_user'
      get 'show_user_posts/:id'      => 'users#show_user_posts'
      get 'show_user_like_posts/:id' => 'users#show_user_like_posts'
      get 'show_user_comments/:id'   => 'users#show_user_comments'
      # post
      get 'find_comments/:id'        => 'posts#find_comments'
      # like
      get 'render_is_like_and_likes_count/:id'   => 'likes#render_is_like_and_likes_count'
    end
  end
end

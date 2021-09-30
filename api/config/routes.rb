Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[show create update] do
        resources :relationships, only: %i[create destroy]
        get :is_following
      end
      resources :posts        , only: %i[index show create update destroy]
      resources :likes        , only: %i[      show create        destroy]
      resources :chats        , only: %i[      show create update        ]
      resources :notifications, only: %i[      show create update        ]
      resources :user_rooms   , only: %i[      show        update        ]
      # user
      get  'find_login_user/:uid'                => 'users#find_login_user'
      get  'show_user_posts/:id'                 => 'users#show_user_posts'
      get  'show_user_like_posts/:id'            => 'users#show_user_like_posts'
      get  'show_user_comments/:id'              => 'users#show_user_comments'
      get  'show_user_posts_have_image/:id'      => 'users#show_user_posts_have_image'
      put  'update_account/:id'                  => 'users#update_account'
      # post
      root 'posts#home'
      post 'create_comment'                      => 'posts#create_comment'
      get  'find_comments/:id'                   => 'posts#find_comments'
      get  'search'                              => 'posts#search'
      # like
      # get   'render_is_like_and_likes_count/:id' => 'likes#render_is_like_and_likes_count'
      # relationship
      get  'find_following/:id'                  => 'relationships#find_following'
      get  'find_followers/:id'                  => 'relationships#find_followers'
      # ActionCable
      mount ActionCable.server                   => '/cable'
      # notification
      get  'find_notifications_count/:id'        => 'notifications#find_notifications_count'
      # chat
      get  'find_unread_chats_count_in_room/:id' => 'chats#find_unread_chats_count_in_room'
      get  'is_exists_unread_chat/:id'           => 'chats#is_exists_unread_chat'
    end
  end
end

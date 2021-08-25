Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :posts   , only: %i[index show create update destroy]
      resources :comments, only: %i[show create update destroy]
      # user
      get 'find_login_user/:uid'  => 'users#find_login_user'
      # like
      post   'like'          => 'likes#like'
      delete 'unlike/:id'    => 'likes#unlike'
      # comment
      get 'search_comments/:id'   => 'comments#search_comments'
    end
  end
end

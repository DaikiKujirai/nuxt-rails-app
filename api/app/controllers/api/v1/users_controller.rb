class Api::V1::UsersController < ApplicationController
  def index
    users = User.all
    render json: users.as_json(only: %i[id name introduction])
  end

  def show
    user = User.find(params[:id])
    render json: user, include: [
                              :posts                          ,
                              :like_posts                     ,
                              :comments                       ,
                              :like_comments                  ,
                              { posts:         [:like_posts] },
                              { posts:         [:comments]   },
                              { comments:      [:user]       },
                            ]
  end

  def create
    user = User.new(user_params)
    user.is_active = true
    if user.save
      render json: user, status: :created
    else
      render json: { errors_message: 'メールアドレスまたはパスワードが正しくありません' }
    end
  end

  def find_login_user
    user = User.find_by(uid: params[:uid])
    render json: user
  end

  def search_likes
    like_posts = []
    like_comments = []

    params[:like_post_ids].each do |post_id|
      like_posts.push(Post.find(post_id))
    end

    params[:like_comment_ids].each do |comment_id|
      like_comments.push(Comment.find(comment_id))
    end

    likes = like_posts.concat(like_comments)

    render json: likes, include: :user
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :uid,
      :introduction,
      :is_active,
      :admin
    )
  end

end

class PostsController < ApplicationController
  before_action :find_user, only: %i[show new create]
  before_action :find_post, only: %i[show]

  # GET /posts or /users/:user_id/posts
  def index
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      if @user
        @posts = @user.posts
      else
        flash[:alert] = 'User not found.'
        redirect_to root_path and return
      end
    else
      @posts = Post.all
    end
  end

  # GET /users/:user_id/posts/:id
  def show; end

  # GET /users/:user_id/posts/new
  def new
    @post = @user.posts.build
  end

  # POST /users/:user_id/posts
  def create
    @post = @user.posts.build(post_params)
    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'User not found.'
    redirect_to root_path
  end

  def find_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Post not found.'
    redirect_to user_posts_path(@user)
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body)
  end
end

class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @like = Like.new(user: @user, post: @post)

    if @like.save
      @post.increment!(:likes_counter)
      redirect_to [@user, @post], notice: 'You liked a post!'
    else
      render :new
    end
  end
end

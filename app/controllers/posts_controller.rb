class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.includes(:user)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.valid?
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end


  def edit
    if @post.user != current_user
      redirect_to root_path
    end
  end



  def update
    if @post.update(post_params)
      redirect_to post_path(@post.id), method: :get
    else
      render :edit
    end
  end


  def destroy
    @post.destroy
    redirect_to root_path
  end

  def set_post
    @post = Post.find(params[:id])
  end

  private
  def post_params
    params.require(:post).permit(:text, :post_image).merge(user_id: current_user.id)
  end

end

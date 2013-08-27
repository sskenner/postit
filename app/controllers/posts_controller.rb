class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:notice] = "you created a new post"
      redirect_to posts_path
    else
      #handle validations
      render :new
    end
  end

  def edit
  end

  def update
  end

  private

  def post_params
    params.require(:post).permit(:title, :url)
  end
end

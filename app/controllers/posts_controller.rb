class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, only: [:new, :create, :edit, :update, :vote]
  before_action :require_creator, only: [:edit, :update]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

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
    if @post.update(post_params)
      flash[:notice] = "you updated the post"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def vote
    Vote.create(voteable: @post, creator: current_user, vote: params[:vote])

    respond_to do |format|
      format.html do
        flash[:notice] = 'your vote was counted'
        redirect_to :back
      end

      format.js

    end
  end


  private

  def post_params
    params.require(:post).permit(:title, :url)
  end

  def set_post
    @post = Post.find_by(slug: params[:id])
  end

  def require_creator
    access_denied unless @post.creator == current_user
  end
end

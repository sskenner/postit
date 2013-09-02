class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, only: [:new, :create, :edit, :update, :vote]
  before_action :require_creator_or_admin, only: [:edit, :update]

  def index
    @posts = Post.all

    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def show
    respond_to do  |format|
      format.html{ @comment = Comment.new }
      format.json { render json: @post }
    end
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
    @vote = Vote.new(voteable: @post, creator: current_user, vote: params[:vote])
    @vote.save

    respond_to do |format|
      format.html do
        flash[:notice] = 'your vote was counted'
        redirect_to :back
      end

      format.js # render /views/posts/vote.js.erb
    end
  end


  private

  def post_params
    params.require(:post).permit(:title, :url)
  end

  def set_post
    @post = Post.find_by(slug: params[:id])
  end

  def require_creator_or_admin
    access_denied unless logged_in? && (@post.creator == current_user || current_user.admin?)
  end
end

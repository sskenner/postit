class CategoriesController < ApplicationController
  before_action :require_admin

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params.require(:category).permit(:name))

    if @category.save
      flash[:notice] = 'new category created!'
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @category = Category.find_by(params[:category])
  end
end

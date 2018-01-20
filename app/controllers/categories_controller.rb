class CategoriesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      flash[:success] = 'Category created'
      redirect_to categories_path
    else
      flash.now[:danger] = @category.errors.values.flatten
      render 'new'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :status)
  end
end

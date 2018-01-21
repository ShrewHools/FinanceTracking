class CategoriesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @income_categories = current_user.categories.where(status: 'income')
    @expense_categories = current_user.categories.where(status: 'expense')
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
      flash.now[:danger] = @category.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def edit
    @category = current_user.categories.find_by(id: params[:id])
    redirect_to categories_path, flash: { danger: 'Category not found' } unless @category
  end

  def update
    @category = current_user.categories.find_by(id: params[:id])
    if @category.update_attributes(category_params)
      redirect_to categories_path, flash: { success: 'Category updated' }
    else
      flash.now[:danger] = @category.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def destroy
    @category = current_user.categories.find_by(id: params[:id])
    if @category
      @category.destroy
      redirect_to categories_path, flash: { success: 'Category deleted' }
    else
      redirect_to categories_path, flash: { danger: 'Category not found' }
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :status)
  end
end

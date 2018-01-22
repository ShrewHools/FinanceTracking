class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :current_category, only: %i[edit update destroy]

  def index
    @income_categories = current_user.categories.income_categories
    @expense_categories = current_user.categories.expense_categories
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      redirect_to categories_path, flash: { success: 'Category created' }
    else
      flash.now[:danger] = @category.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def edit
    redirect_to categories_path, flash: { danger: 'Category not found' } unless @category
  end

  def update
    if @category.update_attributes(category_params)
      redirect_to categories_path, flash: { success: 'Category updated' }
    else
      flash.now[:danger] = @category.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def destroy
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

  def current_category
    @category = current_user.categories.find_by(id: params[:id])
  end
end

class IncomesController < ApplicationController
  before_filter :authenticate_user!

  def show
  end

  def new
    @income = Income.new
    @categories = current_user.categories.where(status: 'income')
  end

  def create
    @income = current_user.incomes.build(income_params)
    if @income.save
      redirect_to root_path, flash: { success: 'Income created' }
    else
      redirect_to new_income_path, flash: { danger: "#{@income.errors.values.flatten}" }
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def income_params
    params.require(:income).permit(:when, :amount, :category_id, :description)
  end
end

class ExpensesController < ApplicationController
  before_filter :authenticate_user!
  before_action :current_expense, only: [:show, :edit, :update, :destroy]

  def index
    @expenses = current_user.expenses.order(when: :desc)
  end

  def show
    redirect_to root_path, flash: { danger: 'Expense not found' } unless @expense
  end

  def new
    @expense = Expense.new
    @categories = current_user.categories.where(status: 'expense')
  end

  def create
    @expense = current_user.expenses.build(expense_params)
    if @expense.save
      redirect_to root_path, flash: { success: 'Expense created' }
    else
      redirect_to new_expense_path, flash: { danger: "#{@expense.errors.values.flatten}" }
    end
  end

  def edit
    @categories = current_user.categories.where(status: 'expense')
    redirect_to root_path, flash: { danger: 'Expense not found' } unless @expense
  end

  def update
    if @expense.update_attributes(expense_params)
      redirect_to @expense, flash: { success: 'Expense updated' }
    else
      redirect_to edit_expense_path(@expense), flash: { danger: "#{@expense.errors.values.flatten}" }
    end
  end

  def destroy
    if @expense
      @expense.destroy
      redirect_to root_path, flash: { success: 'Expense deleted' }
    else
      redirect_to root_path, flash: { danger: 'Expense not found' }
    end
  end

  private

  def expense_params
    params.require(:expense).permit(
      :amount,
      :description,
      :category_id,
      :when
    )
  end

  def current_expense
    @expense = current_user.expenses.find_by(id: params[:id])
  end
end

class IncomesController < ApplicationController
  before_filter :authenticate_user!
  before_action :current_income, only: [:show, :edit, :update, :destroy]

  def index
    @incomes = current_user.incomes.order(when: :desc)
  end

  def show
    redirect_to root_path, flash: { danger: 'Income not found' } unless @income
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
      redirect_to new_income_path, flash: { danger: @income.errors.full_messages.to_sentence }
    end
  end

  def edit
    @categories = current_user.categories.where(status: 'income')
    redirect_to root_path, flash: { danger: 'Income not found' } unless @income
  end

  def update
    if @income.update_attributes(income_params)
      redirect_to @income, flash: { success: 'Income updated' }
    else
      redirect_to edit_income_path(@income), flash: { danger: @income.errors.full_messages.to_sentence }
    end
  end

  def destroy
    if @income
      @income.destroy
      redirect_to root_path, flash: { success: 'Income deleted' }
    else
      redirect_to root_path, flash: { danger: 'Income not found' }
    end
  end

  private

  def income_params
    params.require(:income).permit(
      :amount,
      :description,
      :category_id,
      :when
    )
  end

  def current_income
    @income = current_user.incomes.find_by(id: params[:id])
  end
end

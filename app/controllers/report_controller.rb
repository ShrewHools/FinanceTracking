class ReportController < ApplicationController
  MIN_DATE = Date.iso8601('1800-01-01')
  MAX_DATE = Date.iso8601('2800-01-01')

  before_action :authenticate_user!, only: :search

  def index
    return unless current_user
    @expenses = current_user.expenses
    @expense_categories = current_user.categories.expense_categories

    @incomes = current_user.incomes
    @income_categories = current_user.categories.income_categories

    set_amount
  end

  def search
    min_range = params[:min_range].present? ?  params[:min_range].to_date : MIN_DATE
    max_range = params[:max_range].present? ?  params[:max_range].to_date : MAX_DATE
    category_id = params[:category_id] if params[:category_id].present?
    if category_id
      category = current_user.categories.find_by(id: category_id)
      if category.status == 'income'
        @incomes = current_user.incomes.where(category_id: category_id).where(when: min_range..max_range)
      else
        @expenses = current_user.expenses.where(category_id: category_id).where(when: min_range..max_range)
      end
    else
      @incomes = current_user.incomes.where(when: min_range..max_range)
      @expenses = current_user.expenses.where(when: min_range..max_range)
    end

    set_amount
  end

  private

  def set_amount
    @expenses_amount = @expenses.present? ? @expenses.sum(&:amount) : 0
    @incomes_amount = @incomes.present? ? @incomes.sum(&:amount) : 0
    @all_finances = @incomes_amount - @expenses_amount
  end
end

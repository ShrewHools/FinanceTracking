class ReportController < ApplicationController
  MIN_DATE = Date.iso8601('1800-01-01')
  MAX_DATE = Date.iso8601('2800-01-01')

   before_filter :authenticate_user!, only: :search

  def index
    if current_user
      @expenses = current_user.expenses.order(when: :desc)
      @expense_categories = current_user.categories.where(status: 'expense')
      @incomes = current_user.incomes.order(when: :desc)
      @income_categories = current_user.categories.where(status: 'income')
    end
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
  end
end

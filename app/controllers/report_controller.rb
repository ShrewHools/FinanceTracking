class ReportController < ApplicationController
  def index
    if current_user
      @expenses = current_user.expenses.order(when: :desc)
      @incomes = current_user.incomes.order(when: :desc)
    end
  end
end

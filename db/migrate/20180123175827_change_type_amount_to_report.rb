class ChangeTypeAmountToReport < ActiveRecord::Migration[5.0]
  def change
    change_column :incomes, :amount, :decimal, precision: 10, scale: 2
    change_column :expenses, :amount, :decimal, precision: 10, scale: 2
  end
end

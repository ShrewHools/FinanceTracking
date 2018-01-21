class CreateExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :expenses do |t|
      t.float :amount
      t.date :when
      t.text :description
      t.references :user
      t.references :category
      t.timestamps
    end
  end
end

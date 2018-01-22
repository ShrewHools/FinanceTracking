class Expense < ApplicationRecord
  default_scope { order(when: :desc) }

  belongs_to :user
  belongs_to :category

  validates :amount, presence: true
  validates :when, presence: true, date: true
  validates :category_id, presence: true
  validates :user_id, presence: true
end

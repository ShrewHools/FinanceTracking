class Category < ApplicationRecord
  scope :income_categories, -> { where(status: 'income') }
  scope :expense_categories, -> { where(status: 'expense') }

  enum statuses: { income: 0, expense: 1 }

  belongs_to :user
  has_many :incomes, dependent: :destroy
  has_many :expenses, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }
  validates :status, presence: true
  validates :user_id, presence: true
end

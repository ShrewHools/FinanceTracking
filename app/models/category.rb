class Category < ApplicationRecord
  enum statuses: { income: 0, expense: 1 }

  belongs_to :user
  has_many :incomes, dependent: :destroy
  has_many :expenses, dependent: :destroy

  validates :name, presence: true, length: { maximum: 40 }
  validates :status, presence: true
  validates :user_id, presence: true
end

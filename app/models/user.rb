class User < ApplicationRecord
  has_many :categories, dependent: :destroy
  has_many :incomes, dependent: :destroy
  has_many :expenses, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

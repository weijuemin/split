class Expense < ApplicationRecord
	belongs_to :group
	has_many :records
	has_many :users, through: :records
	has_many :outstandings

	validates :name, :amount, presence: true
	validates :amount, numericality: { greater_than_or_equal_to: 0 }
end

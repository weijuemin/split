class Expense < ApplicationRecord
<<<<<<< HEAD
	belongs_to :group
	has_many :records
	has_many :users, through: :records
	has_many :outstandings
end

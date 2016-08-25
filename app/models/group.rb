class Group < ApplicationRecord
	has_many :expenses
	has_many :user_groups
	has_many :users, through: :user_groups

  validates_presence_of :name
end

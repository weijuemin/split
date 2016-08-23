class User < ApplicationRecord
  has_secure_password
  has_many :user_groups
  has_many :groups, through: :user_groups
  has_many :records
  has_many :outstandings
  has_many :expenses, through: :records
end

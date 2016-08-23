class Expense < ApplicationRecord
  has_many :records
  belongs_to :group
end

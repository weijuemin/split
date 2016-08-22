class Outstanding < ApplicationRecord
  belongs_to :expense
  belongs_to :owes, class_name: "User"
  belongs_to :owed, class_name: "User"
end

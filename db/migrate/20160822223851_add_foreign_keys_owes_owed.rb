class AddForeignKeysOwesOwed < ActiveRecord::Migration[5.0]
  def change
    add_reference :outstandings, :owes, references: :users
    add_reference :outstandings, :owed, references: :users
  end
end

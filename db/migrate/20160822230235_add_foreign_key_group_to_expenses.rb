class AddForeignKeyGroupToExpenses < ActiveRecord::Migration[5.0]
  def change
    add_reference :expenses, :group
  end
end

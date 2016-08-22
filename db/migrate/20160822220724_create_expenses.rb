class CreateExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :expenses do |t|
      t.string :name
      t.float :amount
      t.boolean :completed

      t.timestamps
    end
  end
end

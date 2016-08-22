class CreateRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :records do |t|
      t.references :user, foreign_key: true
      t.references :expense, foreign_key: true
      t.float :paid
      t.float :amount

      t.timestamps
    end
  end
end

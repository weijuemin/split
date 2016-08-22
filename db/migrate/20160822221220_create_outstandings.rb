class CreateOutstandings < ActiveRecord::Migration[5.0]
  def change
    create_table :outstandings do |t|
      t.float :amount
      t.references :expense, foreign_key: true

      t.timestamps
    end
  end
end

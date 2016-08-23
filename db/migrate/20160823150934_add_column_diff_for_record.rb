class AddColumnDiffForRecord < ActiveRecord::Migration[5.0]
  def change
  	add_column :records, :diff, :float
  end
end

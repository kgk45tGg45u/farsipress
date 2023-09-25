class AddColumnToSandboxes < ActiveRecord::Migration[7.0]
  def change
    add_column :sandboxes, :date, :string
  end
end

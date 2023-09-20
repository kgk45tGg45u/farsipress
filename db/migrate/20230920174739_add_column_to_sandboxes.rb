class AddColumnToSandboxes < ActiveRecord::Migration[7.0]
  def change
    add_column :sandboxes, :photo_url, :string
  end
end

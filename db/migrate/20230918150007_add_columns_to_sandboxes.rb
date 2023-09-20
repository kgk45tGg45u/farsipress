class AddColumnsToSandboxes < ActiveRecord::Migration[7.0]
  def change
    add_column :sandboxes, :edited_title, :string
    add_column :sandboxes, :edited_content, :text
  end
end

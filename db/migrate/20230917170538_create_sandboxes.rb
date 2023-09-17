class CreateSandboxes < ActiveRecord::Migration[7.0]
  def change
    create_table :sandboxes do |t|
      t.string :title
      t.text :content
      t.string :source

      t.timestamps
    end
  end
end

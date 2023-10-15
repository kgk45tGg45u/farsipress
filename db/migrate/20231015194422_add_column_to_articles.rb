class AddColumnToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :cloudinary_url, :string
  end
end

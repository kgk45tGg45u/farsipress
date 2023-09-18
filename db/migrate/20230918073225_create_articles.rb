class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.string :date
      t.string :author
      t.boolean :published
      t.string :category
      t.boolean :original

      t.timestamps
    end
  end
end

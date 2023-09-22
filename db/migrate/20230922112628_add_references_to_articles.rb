class AddReferencesToArticles < ActiveRecord::Migration[7.0]
  def change
    add_reference :articles, :category, foreign_key: true
  end
end

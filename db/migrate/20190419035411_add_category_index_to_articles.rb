class AddCategoryIndexToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :category, :integer, default: 0
  end
end

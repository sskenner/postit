class CreatePostCategories < ActiveRecord::Migration
  def change
    create_table :post_categories do |t|
      t.integer :post_id, :category_id

      t.timestamps
    end
  end
end

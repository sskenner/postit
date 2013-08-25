class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, :url
      t.text :description

      t.timestamps
    end
  end
end

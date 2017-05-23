class CreateForumPosts < ActiveRecord::Migration
  def change
    create_table :forum_posts do |t|
      t.string :name, :limit => 50, :null => false
      t.string :subject, :limit => 255, :null => false
      t.text :body
      t.integer :root_id, :null => false, :default => 0
      t.integer :parent_id, :null => false, :default => 0
      t.integer :depth, :null => false, :default => 0

      t.timestamps
    end
  end
end

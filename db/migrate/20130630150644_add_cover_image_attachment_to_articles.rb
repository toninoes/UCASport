class AddCoverImageAttachmentToArticles < ActiveRecord::Migration
  def up
    add_attachment :articles, :cover_image
  end

  def down
    remove_attachment :articles, :cover_image
  end
end

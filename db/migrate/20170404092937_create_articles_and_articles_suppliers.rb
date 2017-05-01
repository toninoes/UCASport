class CreateArticlesAndArticlesSuppliers < ActiveRecord::Migration
  def up
    create_table :articles do |t|
      t.string :title, :limit => 255, :null => false
      t.integer :manufacturer_id, :null => false
      t.datetime :manufactured_at
      t.string :reference, :limit => 13, :unique => true
      t.text :blurb
      t.integer :size
      t.float :price
      t.timestamps
    end

    create_table :articles_suppliers do |t|
      t.integer :supplier_id, :null => false
      t.integer :article_id, :null => false
      t.timestamps
    end

    say_with_time 'Adding foreing keys' do
      # Add foreign key reference to articles_suppliers table
      execute 'ALTER TABLE articles_suppliers ADD CONSTRAINT fk_articles_suppliers_suppliers
              FOREIGN KEY (supplier_id) REFERENCES suppliers(id) ON DELETE CASCADE'
      execute 'ALTER TABLE articles_suppliers ADD CONSTRAINT fk_articles_suppliers_articles
              FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE'
      # Add foreign key reference to manufacturers table
      execute 'ALTER TABLE articles ADD CONSTRAINT fk_articles_manufacturers
              FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(id) ON DELETE CASCADE'
    end
  end

  def self.down
    drop_table :articles
    drop_table :articles_suppliers
  end
end

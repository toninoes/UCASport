class CreateManufacturers < ActiveRecord::Migration
  def change
    create_table :manufacturers do |t|
      t.string :name, :limit => 255, :null => false, :unique => true
      t.timestamps
    end
  end
end

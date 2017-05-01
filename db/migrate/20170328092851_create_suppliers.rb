class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :first_name, :limit => 255, :null => false
      t.string :last_name, :limit => 255, :null => false
      t.timestamps null: false
    end
  end
end

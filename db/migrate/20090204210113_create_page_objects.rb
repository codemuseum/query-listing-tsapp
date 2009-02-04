class CreatePageObjects < ActiveRecord::Migration
  def self.up
    create_table :page_objects do |t|
      t.string :urn
      t.string :header
      t.string :data_path
      t.string :order_by
      t.string :order_direction
      t.integer :limit
      t.integer :update_frequency, :default => 0, :null => false

      t.timestamps
    end
    add_index :page_objects, :urn
  end

  def self.down
    drop_table :page_objects
  end
end

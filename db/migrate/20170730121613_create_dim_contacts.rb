class CreateDimContacts < ActiveRecord::Migration[5.1]
  def self.up
    create_table :dim_contacts do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :dim_contacts, :name, unique: true
  end
  def self.down
    drop_table :dim_contacts
  end
end

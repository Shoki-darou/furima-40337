class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :phone_number, null: false
      t.string :zip_code,     null: false
      t.string :town,         null: false
      t.string :house_number, null: false
      t.string :building_name
      t.integer :city_id,     null: false
      t.references :order,    null: false, foreign_key: true
      t.timestamps
    end
  end
end

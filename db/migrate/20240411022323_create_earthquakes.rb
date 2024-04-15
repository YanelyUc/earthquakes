class CreateEarthquakes < ActiveRecord::Migration[7.0]
  def change
    create_table :earthquakes do |t|
      t.string :type
      t.string :mag_type, null: false
      t.string :external_id
      t.decimal :magnitude, precision: 8, scale: 2
      t.string :place, null: false
      t.string :time
      t.boolean :tsunami, default: false
      t.string :title, null: false
      t.string :url, null: false

      t.timestamps
    end
  end
end

class CreateCoordinates < ActiveRecord::Migration[7.0]
  def change
    create_table :coordinates do |t|
      t.decimal :longitude, precision: 11, scale: 7, null: false
      t.decimal :latitude, precision: 11, scale: 7, null: false
      t.references :earthquake, null: false, foreign_key: true

      t.timestamps
    end
  end
end

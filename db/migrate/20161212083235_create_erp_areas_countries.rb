class CreateErpAreasCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_areas_countries do |t|
      t.string :name
      t.string :code
      t.boolean :archived, default: false

      t.timestamps
    end
  end
end

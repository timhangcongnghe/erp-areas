class CreateErpAreasStates < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_areas_states do |t|
      t.string :name
      t.string :code
      t.boolean :archived, default: false
      t.references :country, index: true, references: :erp_areas_countries

      t.timestamps
    end
  end
end

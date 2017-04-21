class CreateErpAreasDistricts < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_areas_districts do |t|
      t.string :name
      t.references :state, index: true, references: :erp_areas_states

      t.timestamps
    end
  end
end

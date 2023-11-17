class CreateSquads < ActiveRecord::Migration[7.0]
  def change
    create_table :squads do |t|
      t.text :name
      t.integer :dri_id

      t.timestamps
    end
  end
end

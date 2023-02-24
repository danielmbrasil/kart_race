class CreatePlacements < ActiveRecord::Migration[7.0]
  def change
    create_table :placements do |t|
      t.integer :position, null: false

      t.belongs_to :racer
      t.belongs_to :race

      t.index %i[racer_id race_id], unique: true
      t.index %i[position race_id], unique: true

      t.timestamps
    end
  end
end

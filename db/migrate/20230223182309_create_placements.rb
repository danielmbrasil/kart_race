class CreatePlacements < ActiveRecord::Migration[7.0]
  def change
    create_table :placements do |t|
      t.integer :position, null: false

      t.belongs_to :racer

      t.timestamps
    end
  end
end

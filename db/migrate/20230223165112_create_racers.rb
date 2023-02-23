class CreateRacers < ActiveRecord::Migration[7.0]
  def change
    create_table :racers do |t|
      t.string :name, null: false
      t.date :born_at, null: false
      t.string :image_url

      t.timestamps
    end
  end
end

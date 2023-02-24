class CreateRaces < ActiveRecord::Migration[7.0]
  def change
    create_table :races do |t|
      t.date :date, null: false
      t.string :place, null: false, default: ''

      t.timestamps
    end
  end
end

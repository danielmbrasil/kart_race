class AddBelongToTournamentInRace < ActiveRecord::Migration[7.0]
  def change
    add_belongs_to :races, :tournament
  end
end

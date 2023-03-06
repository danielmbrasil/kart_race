# frozen_string_literal: true

json.array! @races do |race|
  json.id race.id
  json.tournament_id race.tournament.id
  json.place race.place
  json.date race.date.strftime('%Y/%m/%d')

  json.placements race.placements.order(:position) do |placement|
    json.id placement.id
    json.racer_id placement.racer_id
    json.position placement.position
  end
end

# frozen_string_literal: true

json.id @tournament.id
json.name @tournament.name

json.racers @racers do |racer|
  json.id racer.id
  json.name racer.name
  json.born_at racer.born_at
  json.image_url racer.image_url
  json.points racer.points
end

json.races @tournament.races do |race|
  json.id race.id
  json.place race.place
  json.date race.date.strftime('%Y/%m/%d')
end

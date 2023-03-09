# frozen_string_literal: true

json.array! @tournaments do |tournament|
  json.id tournament.id
  json.name tournament.name

  json.races tournament.races do |race|
    json.id race.id
    json.place race.place
    json.date race.date.strftime('%Y/%m/%d')
  end
end

# frozen_string_literal: true

json.id @racer.id
json.name @racer.name
json.born_at @racer.born_at.strftime('%d/%m/%Y')
json.image_url @racer.image_url if @racer.image_url.present?

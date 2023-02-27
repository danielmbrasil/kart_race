# frozen_string_literal: true

Rails.application.routes.draw do
  resources :racers
  resources :races, expect: %i[put patch]
end

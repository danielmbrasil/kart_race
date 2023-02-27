# frozen_string_literal: true

# RacesController
class RacesController < ApplicationController
  def index
    @races = Race.all
  end
end

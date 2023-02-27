# frozen_string_literal: true

# RacersController
class RacersController < ApplicationController
  def index
    @racers = Racer.all
  end
end

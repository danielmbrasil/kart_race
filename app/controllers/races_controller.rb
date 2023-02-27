# frozen_string_literal: true

# RacesController
class RacesController < ApplicationController
  before_action :find_race, only: :show

  def index
    @races = Race.all
  end

  def show; end

  private

  def find_race
    @race = Race.find(params[:id])
  end
end

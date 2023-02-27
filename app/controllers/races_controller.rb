# frozen_string_literal: true

# RacesController
class RacesController < ApplicationController
  before_action :find_race, only: :show

  def index
    @races = Race.all
  end

  def show; end

  def create
    @race = Race.new(race_params)

    if @race.save
      render :show, status: :ok
    else
      render json: { errors: @race.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def find_race
    @race = Race.find(params[:id])
  end

  def race_params
    params.permit(
      :tournament_id,
      :place,
      :date,
      placements_attributes: %i[racer_id position]
    )
  end
end

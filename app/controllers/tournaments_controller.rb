# frozen_string_literal: true

# TournamentsController
class TournamentsController < ApplicationController
  before_action :find_tournament, only: :show

  def index
    @tournaments = Tournament.all
  end

  def show
    @racers = RankRacersByPointsQuery.call(params[:id])
  end

  def create
    @tournament = Tournament.new(tournament_params)

    if @tournament.save
      render :show, status: :ok
    else
      render json: { errors: @tournament.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def find_tournament
    @tournament = Tournament.includes(:races).find(params[:id])
  end

  def tournament_params
    params.require(:tournament).permit(:name)
  end
end

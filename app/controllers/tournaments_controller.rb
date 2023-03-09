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

  private

  def find_tournament
    @tournament = Tournament.includes(:races).find(params[:id])
  end
end

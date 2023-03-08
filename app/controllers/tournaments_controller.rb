# frozen_string_literal: true

# TournamentsController
class TournamentsController < ApplicationController
  before_action :find_tournament, only: :show

  def index
    @tournaments = Tournament.all
  end

  def show
    @racers = Racer.from_tournament(params[:id])
  end

  private

  def find_tournament
    @tournament = Tournament.find(params[:id])
  end
end

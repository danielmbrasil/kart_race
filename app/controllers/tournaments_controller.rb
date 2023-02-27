# frozen_string_literal: true

# TournamentsController
class TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.all
  end
end

# frozen_string_literal: true

# RacersController
class RacersController < ApplicationController
  before_action :find_racer, only: %i[show update destroy]

  def index
    @racers = Racer.all
  end

  def show; end

  def create
    @racer = Racer.new(racer_params)

    if @racer.save
      render :show, status: :ok
    else
      render json: { errors: @racer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @racer.update(racer_params)

    if @racer.save
      render :show, status: :ok
    else
      render json: { errors: @racer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @racer.destroy
    render json: { message: 'Sucess' }, status: :ok
  end

  private

  def find_racer
    @racer = Racer.find(params[:id])
  end

  def racer_params
    params.permit(:name, :born_at, :image_url)
  end
end

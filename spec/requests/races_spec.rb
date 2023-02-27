# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'Races', type: :request do
  let(:default_header) { { 'Accept': 'application/json' } }

  describe 'GET /races' do
    context 'when there is no race' do
      it 'returns HTTP status OK' do
        get '/races', headers: default_header

        expect(response).to have_http_status(:ok)
      end

      it 'returns an empty array' do
        get '/races', headers: default_header

        response_body = JSON.parse(response.body)

        expect(response_body).to eq([])
      end
    end

    context 'when there are races with no placement' do
      let!(:races) { create_list(:race, 5) }

      let(:expected_response_body) do
        races.map do |race|
          {
            id: race.id,
            tournament_id: race.tournament.id,
            place: race.place,
            date: race.date.strftime('%Y/%m/%d'),
            placements: []
          }.with_indifferent_access
        end
      end

      it 'returns HTTP status OK' do
        get '/races', headers: default_header

        expect(response).to have_http_status(:ok)
      end

      it 'returns an array with races with empty placements array' do
        get '/races', headers: default_header

        response_body = JSON.parse(response.body)

        expect(response_body).to eq(expected_response_body)
      end
    end

    context 'when there are races with placements' do
      let(:placements) do
        [
          build(:placement, position: 2, race: nil),
          build(:placement, position: 1, race: nil)
        ]
      end

      let!(:races) { create_list(:race, 5, placements:) }

      let(:expected_response_body) do
        races.map do |race|
          {
            id: race.id,
            tournament_id: race.tournament.id,
            place: race.place,
            date: race.date.strftime('%Y/%m/%d'),
            placements: race.placements.order(:position).map do |placement|
              {
                id: placement.id,
                racer_id: placement.racer_id,
                position: placement.position
              }.with_indifferent_access
            end
          }.with_indifferent_access
        end
      end

      it 'returns HTTP status OK' do
        get '/races', headers: default_header

        expect(response).to have_http_status(:ok)
      end

      it 'returns an array with races with placements ordered by position' do
        get '/races', headers: default_header

        response_body = JSON.parse(response.body)

        expect(response_body).to eq(expected_response_body)
      end
    end
  end

  describe 'GET /show/:id' do
    context 'when race is not found' do
      it 'returns HTTP status NOT FOUND' do
        get '/races/:id', headers: default_header

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when race has no placement' do
      let(:race) { create(:race) }

      let(:expected_response_body) do
        {
          id: race.id,
          tournament_id: race.tournament.id,
          place: race.place,
          date: race.date.strftime('%Y/%m/%d'),
          placements: []
        }.with_indifferent_access
      end

      it 'returns HTTP status OK' do
        get "/races/#{race.id}", headers: default_header

        expect(response).to have_http_status(:ok)
      end

      it 'returns race with empty replacement array' do
        get "/races/#{race.id}", headers: default_header

        response_body = JSON.parse(response.body)

        expect(response_body).to eq(expected_response_body)
      end
    end

    context 'when race has placements' do
      let(:placements) do
        [
          build(:placement, position: 2, race: nil),
          build(:placement, position: 1, race: nil)
        ]
      end

      let(:race) { create(:race, placements:) }

      let(:expected_response_body) do
        {
          id: race.id,
          tournament_id: race.tournament.id,
          place: race.place,
          date: race.date.strftime('%Y/%m/%d'),
          placements: race.placements.order(:position).map do |placement|
            {
              id: placement.id,
              racer_id: placement.racer_id,
              position: placement.position
            }.with_indifferent_access
          end
        }.with_indifferent_access
      end

      it 'returns HTTP status OK' do
        get "/races/#{race.id}", headers: default_header

        expect(response).to have_http_status(:ok)
      end

      it 'returns race with empty replacement array' do
        get "/races/#{race.id}", headers: default_header

        response_body = JSON.parse(response.body)

        expect(response_body).to eq(expected_response_body)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength

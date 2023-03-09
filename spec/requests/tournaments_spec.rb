# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'Tournaments', type: :request do
  let(:headers) { { 'Accept': 'application/json', 'Content-Type': 'application/json' } }

  describe 'GET /tournaments' do
    context 'when there are no tournament' do
      it 'returns HTTP status OK' do
        get('/tournaments', headers:)

        expect(response).to have_http_status(:ok)
      end

      it 'returns an empty array' do
        get('/tournaments', headers:)

        response_body = JSON.parse(response.body)

        expect(response_body).to eq([])
      end
    end

    context 'when there are tournaments' do
      let(:races) { build_list(:race, 3, tournament: nil) }
      let!(:tournaments) { create_list(:tournament, 1, races:) }

      let(:expected_response_body) do
        tournaments.map do |tournament|
          {
            id: tournament.id,
            name: tournament.name,
            races: races.map do |race|
              {
                id: race.id,
                place: race.place,
                date: race.date.strftime('%Y/%m/%d')
              }.with_indifferent_access
            end
          }.with_indifferent_access
        end
      end

      it 'returns HTTP status OK' do
        get('/tournaments', headers:)

        expect(response).to have_http_status(:ok)
      end

      it 'returns an array with tournaments' do
        get('/tournaments', headers:)

        response_body = JSON.parse(response.body)

        expect(response_body).to eq(expected_response_body)
      end
    end
  end

  describe 'POST /tournaments' do
    context 'when params are valid' do
      let(:params) { { 'name' => 'Copa Pistão' }.to_json }

      it 'returns HTTP status OK' do
        post('/tournaments', headers:, params:)

        expect(response).to have_http_status(:ok)
      end

      it 'responds with created tournament' do
        post('/tournaments', headers:, params:)

        expect(JSON.parse(response.body)).to include({ 'name' => 'Copa Pistão' })
      end
    end

    context 'when params are invalid' do
      let(:params) { { 'name' => '' }.to_json }

      it 'returns HTTP status UNPROCESSABLE ENTITY' do
        post('/tournaments', headers:, params:)

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'responds with validation error messages' do
        post('/tournaments', headers:, params:)

        response_body = JSON.parse(response.body)

        expect(response_body['errors']).to include("Name can't be blank")
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength

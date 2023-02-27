# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'Racers', type: :request do
  let(:default_header) { { 'Accept': 'application/json' } }

  describe 'GET #index' do
    context 'when there is no racer' do
      it 'returns HTTP status OK' do
        get '/racers', headers: default_header

        expect(response).to have_http_status(:ok)
      end

      it 'returns an empty array' do
        get '/racers', headers: default_header

        response_body = JSON.parse(response.body)

        expect(response_body).to eq([])
      end
    end

    context 'when there are racers' do
      let!(:racers) { create_list(:racer, 10) }

      let(:expected_response_body) do
        racers.map do |racer|
          {
            id: racer.id,
            name: racer.name,
            born_at: racer.born_at.strftime('%d/%m/%Y'),
            image_url: racer.image_url
          }.with_indifferent_access
        end
      end

      it 'returns HTTP status OK' do
        get '/racers', headers: default_header

        expect(response).to have_http_status(:ok)
      end

      it 'returns an array with racers' do
        get '/racers', headers: default_header

        response_body = JSON.parse(response.body)

        expect(response_body).to eq(expected_response_body)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength

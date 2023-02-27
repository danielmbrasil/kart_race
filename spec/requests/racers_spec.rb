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

  describe 'GET #show' do
    context 'when racer exist' do
      let(:racer) { create(:racer) }

      let(:expected_response_body) do
        {
          id: racer.id,
          name: racer.name,
          born_at: racer.born_at.strftime('%d/%m/%Y'),
          image_url: racer.image_url
        }.with_indifferent_access
      end

      it 'returns HTTP status OK' do
        get "/racers/#{racer.id}", headers: default_header

        expect(response).to have_http_status(:ok)
      end

      it 'returns racer objet correctly' do
        get "/racers/#{racer.id}", headers: default_header

        response_body = JSON.parse(response.body)

        expect(response_body).to eq(expected_response_body)
      end
    end

    context 'when racer is not found' do
      it 'returns HTTP status NOT FOUND' do
        get '/racers/:id', headers: default_header

        expect(response).to have_http_status(:not_found)
      end

      it 'returns error message in response body' do
        expected_response_body = { error: 'Not found' }.with_indifferent_access

        get '/racers/:id', headers: default_header
        response_body = JSON.parse(response.body)

        expect(response_body).to eq(expected_response_body)
      end
    end
  end

  describe 'POST #create' do
    context 'when params are valid' do
      let(:params) do
        {
          name: 'Rubens',
          born_at: '20/02/2000',
          image_url: 'https://example.com/image.png'
        }
      end

      it 'returns HTTP status OK' do
        post '/racers', headers: default_header, params: params

        expect(response).to have_http_status(:ok)
      end

      it 'returns created racer' do
        post '/racers', headers: default_header, params: params

        response_body = JSON.parse(response.body)

        expect(response_body).to include(
          {
            name: 'Rubens',
            born_at: '20/02/2000',
            image_url: 'https://example.com/image.png'
          }.with_indifferent_access
        )
      end
    end

    context 'when params are invalid' do
      context 'when racer is under min age' do
        let(:params) do
          {
            name: 'Rubens',
            born_at: '20/02/2010'
          }
        end

        it 'returns HTTP status UNPROCESSABLE ENTITY' do
          post '/racers', headers: default_header, params: params

          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns an array with error messages' do
          post '/racers', headers: default_header, params: params

          response_body = JSON.parse(response.body)

          expect(response_body['errors']).to include("Born at must be at least #{Racer::MIN_AGE} years old")
        end
      end

      context 'when name is not present' do
        let(:params) do
          {
            born_at: '20/02/2000',
            image_url: 'https://example.com/image.png'
          }
        end

        it 'returns HTTP status UNPROCESSABLE ENTITY' do
          post '/racers', headers: default_header, params: params

          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns an array with error messages' do
          post '/racers', headers: default_header, params: params

          response_body = JSON.parse(response.body)

          expect(response_body['errors']).to include("Name can't be blank")
        end
      end
    end
  end

  describe 'PATCH #update' do
    context 'when racer exists and params are valid' do
      let(:racer) { create(:racer) }
      let(:params) do
        {
          name: 'New name',
          born_at: '20/01/1999'
        }
      end

      it 'returns HTTP status OK' do
        patch "/racers/#{racer.id}", headers: default_header, params: params

        expect(response).to have_http_status(:ok)
      end

      it 'returns updated racer object' do
        patch "/racers/#{racer.id}", headers: default_header, params: params

        response_body = JSON.parse(response.body)

        expect(response_body).to include(
          {
            name: 'New name',
            born_at: '20/01/1999'
          }.with_indifferent_access
        )
      end
    end

    context 'when racer does not exist' do
      it 'returns HTTP status NOT FOUND' do
        patch '/racers/:id', headers: default_header

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when params are invalid' do
      let(:racer) { create(:racer) }
      let(:params) do
        {
          name: 'New name',
          born_at: '20/01/1999',
          image_url: 'invalid.url'
        }
      end

      it 'returns HTTP status UNPROCESSABLE ENTITY' do
        patch "/racers/#{racer.id}", headers: default_header, params: params

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an array with error messages' do
        patch "/racers/#{racer.id}", headers: default_header, params: params

        response_body = JSON.parse(response.body)

        expect(response_body['errors']).to include('Image url is invalid')
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength

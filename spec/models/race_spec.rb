# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Race, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:place) }
    it { is_expected.to validate_presence_of(:date) }

    context 'when there is a repeated racer in a race' do
      let(:race) { create :race }
      let(:racer) { create :racer }

      it 'is an invalid record' do
        race.placements.create(position: 1, racer:)
        race.placements.build(position: 2, racer:)

        expect(race.valid?).to eq(false)
      end

      it 'returns a validation error message' do
        race.placements.create(position: 1, racer:)
        race.placements.build(position: 2, racer:)

        race.validate

        error_message = race.placements.last.errors[:racer_id]

        expect(error_message).to include('has already been taken')
      end
    end

    context 'when there is a repeated position in a race' do
      let(:race) { create :race }
      let(:racer1) { create :racer }
      let(:racer2) { create :racer }

      it 'is an invalid record' do
        race.placements.create(position: 1, racer: racer1)
        race.placements.build(position: 1, racer: racer2)

        expect(race.valid?).to eq(false)
      end

      it 'returns a validation error message' do
        race.placements.create(position: 1, racer: racer1)
        race.placements.build(position: 1, racer: racer2)

        race.validate

        error_message = race.placements.last.errors[:position]

        expect(error_message).to include('has already been taken')
      end
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:placements) }
    it { is_expected.to have_many(:racers) }
    it { is_expected.to belong_to(:tournament) }
  end
end
# rubocop:enable Metrics/BlockLength

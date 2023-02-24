# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Racer, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:born_at) }

    context 'when racer is under min age' do
      subject { build :racer, born_at: Date.today - 15.years }

      it { is_expected.to be_invalid }

      it 'returns validation error message' do
        subject.validate

        expect(subject.errors[:born_at]).to include("must be at least #{Racer::MIN_AGE} years old")
      end
    end

    context 'when racer has exactly min age' do
      subject { build :racer, born_at: Date.today - Racer::MIN_AGE.years }

      it { is_expected.to be_valid }

      it 'does not return validation error message' do
        subject.validate

        expect(subject.errors[:born_at]).to be_empty
      end
    end

    context 'when image_url is invalid' do
      subject { build :racer, image_url: 'some.invalid.url' }

      it { is_expected.to be_invalid }

      it 'returns validation error message' do
        subject.validate

        expect(subject.errors[:image_url]).to include('is invalid')
      end
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:placements) }
    it { is_expected.to have_many(:races) }
  end
end
# rubocop:enable Metrics/BlockLength

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

    context "when racer's age is equal to min age" do
      subject { build :racer, born_at: Date.today - Racer::MIN_AGE.years }

      it { is_expected.to be_valid }
    end

    context 'when image_url is invalid' do
      subject { build :racer, image_url: 'some_invalid_url' }

      it { is_expected.to be_invalid }

      it 'returns validation error message' do
        subject.validate

        expect(subject.errors[:image_url]).to include('is invalid')
      end
    end
  end

  describe 'associations' do
    it { is_expected.to have_one(:placement) }
  end
end
# rubocop:enable Metrics/BlockLength

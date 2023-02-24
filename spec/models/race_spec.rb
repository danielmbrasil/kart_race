# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Race, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:place) }
    it { is_expected.to validate_presence_of(:date) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:placements) }
    it { is_expected.to have_many(:racers) }
  end
end

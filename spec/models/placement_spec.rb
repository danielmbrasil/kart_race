# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Placement, type: :model do
  describe 'validations' do
    subject { create :placement }

    it { is_expected.to validate_uniqueness_of(:position).scoped_to(:race_id) }
    it { is_expected.to validate_numericality_of(:position).only_integer }
    it { is_expected.to validate_numericality_of(:position).is_greater_than(0) }
    it { is_expected.to validate_uniqueness_of(:racer_id).scoped_to(:race_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:racer) }
    it { is_expected.to belong_to(:race) }
  end
end

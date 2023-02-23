# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Placement, type: :model do
  describe 'validations' do
    subject { create :placement }

    it { is_expected.to validate_presence_of(:position) }
    it { is_expected.to validate_numericality_of(:position) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:racer) }
  end
end

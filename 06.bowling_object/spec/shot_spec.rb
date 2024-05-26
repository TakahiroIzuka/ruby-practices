# frozen_string_literal: true

require_relative '../lib/shot'

describe Shot do
  describe 'score' do
    subject { Shot.new(mark).score }

    context 'when mark is number' do
      let(:mark) { '9' }

      it 'return 9' do
        is_expected.to eq 9
      end
    end
    context "when mark is 'X'" do
      let(:mark) { 'X' }

      it 'return 10' do
        is_expected.to eq 10
      end
    end
  end
end

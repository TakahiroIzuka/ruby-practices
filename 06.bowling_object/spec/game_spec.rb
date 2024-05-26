# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  describe 'play and score' do
    subject do
      game = Game.new
      game.play(marks)
    end

    context 'when marks has strike and spare and no mark' do
      let(:marks) { %w[6 3 9 0 0 3 8 2 7 3 X 9 1 8 0 X 6 4 5] }
      it { is_expected.to eq 139 }
    end
    context 'when marks has strike and spare and no mark' do
      let(:marks) { %w[6 3 9 0 0 3 8 2 7 3 X 9 1 8 0 X X X X] }
      it { is_expected.to eq 164 }
    end
    context 'when marks has strike and spare and no mark' do
      let(:marks) { %w[0 10 1 5 0 0 0 0 X X X 5 1 8 1 0 4] }
      it { is_expected.to eq 107 }
    end
    context 'when marks has strike and spare and no mark' do
      let(:marks) { %w[6 3 9 0 0 3 8 2 7 3 X 9 1 8 0 X X 0 0] }
      it { is_expected.to eq 134 }
    end
    context 'when marks has strike and spare and no mark' do
      let(:marks) { %w[6 3 9 0 0 3 8 2 7 3 X 9 1 8 0 X X 1 8] }
      it { is_expected.to eq 144 }
    end
    context 'when all marks are strike' do
      let(:marks) { %w[X X X X X X X X X X X X] }
      it { is_expected.to eq 300 }
    end
    context 'when marks has strike and spare and no mark' do
      let(:marks) { %w[X X X X X X X X X X X 2] }
      it { is_expected.to eq 292 }
    end
    context 'when marks has strike and spare and no mark' do
      let(:marks) { %w[X 0 0 X 0 0 X 0 0 X 0 0 X 0 0] }
      it { is_expected.to eq 50 }
    end
    context 'when all marks are 0' do
      let(:marks) { ['0'] * 20 }
      it { is_expected.to eq 0 }
    end
  end
end

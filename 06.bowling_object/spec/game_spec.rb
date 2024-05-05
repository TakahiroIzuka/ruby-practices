# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  describe 'play and score' do
    subject do
      game = Game.new
      game.play(marks)
      game.score
    end

    context 'when marks has strike and spare and no mark' do
      let(:marks) { %w[6 3 9 0 0 3 8 2 7 3 X 9 1 8 0 X 6 4 5] }
      it 'return 139' do
        is_expected.to eq 139
      end
    end

    context 'when all marks are 0' do
      let(:marks) { ['0'] * 20 }
      it 'return 0' do
        is_expected.to eq 0
      end
    end

    context 'when all marks are strike' do
      let(:marks) { %w[X X X X X X X X X X X X] }
      it 'return 300' do
        is_expected.to eq 300
      end
    end

    context 'when too many marks ' do
      let(:marks) { %w[X X X X X X X X X X X X X] }

      it 'return 300' do
        is_expected.to eq 300
      end
    end

    context 'when too few marks ' do
      let(:marks) { %w[X X X X X X X X X X] }

      it 'return exception' do
        expect { subject }.to raise_error 'Invalid frame (Next frame is not full)'
      end
    end

    context 'when call score before call play' do
      it 'return 0' do
        game = Game.new
        expect(game.score).to eq 0
      end
    end
  end
end

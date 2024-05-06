# frozen_string_literal: true

require_relative '../lib/shot'
require_relative '../lib/frame'
require_relative '../lib/last_frame'

describe LastFrame do
  describe 'frame' do
    subject do
      frame = LastFrame.new
      frame.set(first_shot)
      frame.set(second_shot)
      frame.set(third_shot)
    end

    context 'when first shot is 1 and second shot is X' do
      let(:first_shot) { Shot.new('1') }
      let(:second_shot) { Shot.new('X') }

      it 'exception occurs' do
        expect { subject }.to raise_error 'Invalid shot (X can mark only after X)'
      end
    end

    context 'when first shot is 9 and second shot is 2' do
      let(:first_shot) { Shot.new('9') }
      let(:second_shot) { Shot.new('2') }

      it 'exception occurs' do
        expect { subject }.to raise_error 'Invalid shot (Total score is at least 10 by the second shot unless first shot is X)'
      end
    end

    context 'when first shot is X and second shot is 9 and third shot is 2' do
      let(:first_shot) { Shot.new('X') }
      let(:first_shot) { Shot.new('9') }
      let(:second_shot) { Shot.new('2') }

      it 'exception occurs' do
        expect { subject }.to raise_error 'Invalid shot (Total score is at least 10 by the second shot unless first shot is X)'
      end
    end
  end

  describe 'full?' do
    context 'when all X' do
      it 'return true, score is 30' do
        frame = LastFrame.new
        frame.set(Shot.new('X'))
        frame.set(Shot.new('X'))
        frame.set(Shot.new('X'))
        expect(frame.full?).to eq true
        expect(frame.score).to eq 30
      end
    end

    context 'when shot is 1, 2, 3' do
      it 'return true, score is 3' do
        frame = LastFrame.new
        frame.set(Shot.new('1'))
        frame.set(Shot.new('2'))
        frame.set(Shot.new('3'))
        expect(frame.full?).to eq true
        expect(frame.score).to eq 3
      end
    end

    context 'when shot is 1, 9, X' do
      it 'return ture, score is 20' do
        frame = LastFrame.new
        frame.set(Shot.new('1'))
        frame.set(Shot.new('9'))
        frame.set(Shot.new('X'))
        expect(frame.full?).to eq true
        expect(frame.score).to eq 20
      end
    end

    context 'when shot is X, 9, 1' do
      it 'return true, score is 20' do
        frame = LastFrame.new
        frame.set(Shot.new('X'))
        frame.set(Shot.new('9'))
        frame.set(Shot.new('1'))
        expect(frame.full?).to eq true
        expect(frame.score).to eq 20
      end
    end
  end

  describe 'strike?' do
    subject do
      frame = LastFrame.new
      frame.set(first_shot)
      frame.set(second_shot)
      frame.strike?
    end

    context 'when first shot is X and second shot is 0' do
      let(:first_shot) { Shot.new('X') }
      let(:second_shot) { Shot.new('X') }

      it 'return false' do
        is_expected.to be false
      end
    end
  end

  describe 'spare?' do
    subject do
      frame = LastFrame.new
      frame.set(first_shot)
      frame.set(second_shot)
      frame.spare?
    end

    context 'when first shot is X and second shot is 0' do
      let(:first_shot) { Shot.new('1') }
      let(:second_shot) { Shot.new('9') }

      it 'return false' do
        is_expected.to be false
      end
    end
  end
end

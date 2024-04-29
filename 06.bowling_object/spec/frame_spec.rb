# frozen_string_literal: true

require_relative '../class/frame'
require_relative '../class/shot'

describe Frame do
  describe 'frame' do
    subject do
      frame = Frame.new
      frame.frame(first_shot)
      frame.frame(second_shot)
    end

    context 'when first shot is X and second shot is 1' do
      let(:first_shot) { Shot.new('X') }
      let(:second_shot) { Shot.new('1') }

      it 'exception occurs' do
        expect { subject }.to raise_error 'Invalid shot (Only 0 after X)'
      end
    end

    context 'when first shot is 1 and second shot is X' do
      let(:first_shot) { Shot.new('1') }
      let(:second_shot) { Shot.new('X') }

      it 'exception occurs' do
        expect { subject }.to raise_error 'Invalid shot (X is only first shot)'
      end
    end

    context 'when score is more than 10' do
      let(:first_shot) { Shot.new('2') }
      let(:second_shot) { Shot.new('9') }

      it 'exception occurs' do
        expect { subject }.to raise_error 'Invalid shot (Total score is at least 10 by the second shot unless first shot is X)'
      end
    end
  end

  describe 'full?' do
    context 'when first shot is 1' do
      it 'return false' do
        frame = Frame.new
        frame.frame(Shot.new('1'))
        expect(frame.full?).to eq false
      end
    end

    context 'when first shot is 1 and second shot is 2' do
      it 'return false' do
        frame = Frame.new
        frame.frame(Shot.new('1'))
        frame.frame(Shot.new('2'))
        expect(frame.full?).to eq true
      end
    end
  end

  describe 'strike?' do
    subject do
      frame = Frame.new
      frame.frame(first_shot)
      frame.frame(second_shot)
      frame.strike?
    end

    context 'when first shot is X and second shot is 0' do
      let(:first_shot) { Shot.new('X') }
      let(:second_shot) { Shot.new('0') }

      it 'return true' do
        is_expected.to be true
      end
    end

    context 'when first shot is 1 and second shot is 9' do
      let(:first_shot) { Shot.new('1') }
      let(:second_shot) { Shot.new('9') }

      it 'return false' do
        is_expected.to be false
      end
    end
  end

  describe 'spare?' do
    subject do
      frame = Frame.new
      frame.frame(first_shot)
      frame.frame(second_shot)
      frame.spare?
    end

    context 'when first shot is X and second shot is 0' do
      let(:first_shot) { Shot.new('X') }
      let(:second_shot) { Shot.new('0') }

      it 'return false' do
        is_expected.to be false
      end
    end

    context 'when first shot is 1 and second shot is 9' do
      let(:first_shot) { Shot.new('1') }
      let(:second_shot) { Shot.new('9') }

      it 'return true' do
        is_expected.to be true
      end
    end
  end
end

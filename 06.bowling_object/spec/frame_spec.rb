# frozen_string_literal: true

require_relative '../class/frame'
require_relative '../class/shot'

describe Frame do
  describe 'score' do
    subject do
      frame = Frame.new(first_shot, second_shot)
      frame.score
    end

    context 'when first shot is 1 and second shot is 9' do
      let(:first_shot) { Shot.new('1') }
      let(:second_shot) { Shot.new('9') }

      it 'return 10' do
        is_expected.to eq 10
      end
    end

    context 'when first shot is X and second shot is 0' do
      let(:first_shot) { Shot.new('X') }
      let(:second_shot) { Shot.new('0') }

      it 'return 10' do
        is_expected.to eq 10
      end
    end

    context 'when first shot is 0 and second shot is X' do
      let(:first_shot) { Shot.new('0') }
      let(:second_shot) { Shot.new('X') }

      it 'return exception' do
        expect { subject }.to raise_error 'Invalid frame (Strike is Only first shot)'
      end
    end

    context 'when first shot is X and second shot is 1' do
      let(:first_shot) { Shot.new('X') }
      let(:second_shot) { Shot.new('1') }
      it 'return exception' do
        expect { subject }.to raise_error 'Invalid frame (No more shot after strike)'
      end
    end

    context 'when first shot is X and second shot is X' do
      let(:first_shot) { Shot.new('X') }
      let(:second_shot) { Shot.new('X') }
      it 'return exception' do
        expect { subject }.to raise_error 'Invalid frame (No more shot after strike)'
      end
    end

    context 'when first shot is 1 and second shot is 10' do
      let(:first_shot) { Shot.new('1') }
      let(:second_shot) { Shot.new('10') }
      it 'return exception' do
        expect { subject }.to raise_error 'Invalid frame (Over 10 scores)'
      end
    end
  end

  describe 'strike?' do
    subject do
      frame = Frame.new(first_shot, second_shot)
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
      frame = Frame.new(first_shot, second_shot)
      frame.spare?
    end

    context 'when first shot is X and second shot is 0' do
      let(:first_shot) { Shot.new('X') }
      let(:second_shot) { Shot.new('0') }

      it 'return true' do
        is_expected.to be false
      end
    end

    context 'when first shot is 1 and second shot is 9' do
      let(:first_shot) { Shot.new('1') }
      let(:second_shot) { Shot.new('9') }

      it 'return false' do
        is_expected.to be true
      end
    end
  end
end

# frozen_string_literal: true

require_relative '../lib/frame'
require_relative '../lib/shot'

describe Frame do
  describe 'set' do
    let!(:frame) { Frame.new(0) }
    let!(:first_mark) { '2' }
    let!(:second_mark) { '5' }

    before do
      frame.set(Shot.new(first_mark))
      frame.set(Shot.new(second_mark))
    end

    it 'can set completely' do
      expect(frame.shots[0].score).to eq 2
      expect(frame.shots[1].score).to eq 5
    end
  end

  describe 'full?' do
    let!(:frame) { Frame.new(0) }
    subject { frame.full? }

    context 'when set only first_shot' do
      before do
        frame.set(Shot.new('1'))
      end

      it { is_expected.to be false }
    end
    context 'when set two shots' do
      before do
        frame.set(Shot.new('1'))
        frame.set(Shot.new('2'))
      end

      it { is_expected.to be true }
    end
    context 'when first_shot mark X' do
      before do
        frame.set(Shot.new('X'))
      end

      it { is_expected.to be true }
    end
  end

  describe 'strike?' do
    let!(:frame) { Frame.new(0) }
    subject { frame.strike? }

    context 'when first shot is X' do
      before do
        frame.set(Shot.new('X'))
      end

      it { is_expected.to be true }
    end
    context 'when sum of the first and second shot is 10' do
      before do
        frame.set(Shot.new('1'))
        frame.set(Shot.new('9'))
      end

      it { is_expected.to be false }
    end
  end

  describe 'spare?' do
    let(:frame) { Frame.new(0) }
    subject { frame.spare? }

    context 'when first shot is X' do
      before do
        frame.set(Shot.new('X'))
      end

      it { is_expected.to be false }
    end
    context 'when sum of the first and second shot is 10' do
      before do
        frame.set(Shot.new('1'))
        frame.set(Shot.new('9'))
      end

      it { is_expected.to be true }
    end
  end
end

# frozen_string_literal: true

require_relative '../lib/shot'
require_relative '../lib/frame'
require_relative '../lib/last_frame'

describe LastFrame do
  describe 'set' do
    let!(:frame) { LastFrame.new(0) }
    let!(:first_mark) { '2' }
    let!(:second_mark) { '5' }

    before do
      frame.set(Shot.new(first_mark))
      frame.set(Shot.new(second_mark))
    end

    it 'can set first and second shot' do
      expect(frame.shots[0].score).to eq 2
      expect(frame.shots[1].score).to eq 5
    end
    context 'when can throw three times' do
      let!(:first_mark) { '1' }
      let!(:second_mark) { '9' }
      let!(:third_mark) { 'X' }

      before do
        frame.set(Shot.new(third_mark))
      end

      it 'can set first and second shot' do
        expect(frame.shots[0].score).to eq 1
        expect(frame.shots[1].score).to eq 9
        expect(frame.shots[2].score).to eq 10
      end
    end
  end

  describe 'full?' do
    let!(:frame) { LastFrame.new(0) }
    subject { frame.full? }

    context 'when set only first_shot' do
      before do
        frame.set(Shot.new('X'))
      end

      it { is_expected.to be false }
    end
    context 'when set two shots' do
      before do
        frame.set(Shot.new('1'))
        frame.set(Shot.new('8'))
      end

      it { is_expected.to be true }
    end
    context 'when set two shots but has X' do
      before do
        frame.set(Shot.new('X'))
        frame.set(Shot.new('9'))
      end

      it { is_expected.to be false }
    end
    context 'when set two shots but sum is equal 10' do
      before do
        frame.set(Shot.new('1'))
        frame.set(Shot.new('9'))
      end

      it { is_expected.to be false }
    end
    context 'when set three shots' do
      before do
        frame.set(Shot.new('1'))
        frame.set(Shot.new('9'))
        frame.set(Shot.new('1'))
      end

      it { is_expected.to be true }
    end
  end

  describe 'strike?' do
    let(:frame) { LastFrame.new(0) }
    subject { frame.strike? }

    context 'when first shot is X' do
      before do
        frame.set(Shot.new('X'))
      end

      it { is_expected.to be false }
    end
  end

  describe 'spare?' do
    let(:frame) { LastFrame.new(0) }
    subject { frame.spare? }

    context 'when sum of the first and second shot is 10' do
      before do
        frame.set(Shot.new('1'))
        frame.set(Shot.new('9'))
      end

      it { is_expected.to be false }
    end
  end
end

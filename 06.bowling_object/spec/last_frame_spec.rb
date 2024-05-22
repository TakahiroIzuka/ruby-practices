# frozen_string_literal: true

require_relative '../lib/shot'
require_relative '../lib/frame'
require_relative '../lib/last_frame'

describe LastFrame do
  describe 'frame' do
    context 'valid shots' do
      let!(:frame) { LastFrame.new }
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
      context 'when first shot is X, second shot is X, third_shot is X' do
        let!(:first_mark) { 'X' }
        let!(:second_mark) { 'X' }
        let!(:third_mark) { 'X' }

        before do
          frame.set(Shot.new(third_mark))
        end

        it 'can set first and second shot' do
          expect(frame.shots[0].score).to eq 10
          expect(frame.shots[1].score).to eq 10
          expect(frame.shots[2].score).to eq 10
        end
      end
      context 'when first shot is X, second shot is 0, third_shot is X' do
        let!(:first_mark) { 'X' }
        let!(:second_mark) { '0' }
        let!(:third_mark) { 'X' }

        before do
          frame.set(Shot.new(third_mark))
        end

        it 'can set first and second shot' do
          expect(frame.shots[0].score).to eq 10
          expect(frame.shots[1].score).to eq 0
          expect(frame.shots[2].score).to eq 10
        end
      end
    end
  end

  describe 'full?' do
    let!(:frame) { LastFrame.new }
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
    let(:frame) { LastFrame.new }
    subject { frame.strike? }

    context 'when first shot is X and second shot is 0' do
      before do
        frame.set(Shot.new('X'))
        frame.set(Shot.new('X'))
      end

      it { is_expected.to be false }
    end
  end

  describe 'spare?' do
    let(:frame) { LastFrame.new }
    subject { frame.spare? }

    context 'when first shot is X and second shot is 0' do
      before do
        frame.set(Shot.new('1'))
        frame.set(Shot.new('9'))
      end

      it { is_expected.to be false }
    end
  end
end

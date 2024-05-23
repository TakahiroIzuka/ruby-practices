# frozen_string_literal: true

require_relative '../lib/frame'
require_relative '../lib/shot'

describe Frame do
  describe 'set' do
    context 'valid shots' do
      let!(:frame) { Frame.new }
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
      context 'when strike' do
        let!(:first_mark) { 'X' }
        let!(:second_mark) { '0' }

        it 'can set completely' do
          expect(frame.shots[0].score).to eq 10
          expect(frame.shots[1].score).to eq 0
        end
      end
      context 'when spare' do
        let!(:first_mark) { '1' }
        let!(:second_mark) { '9' }

        it 'can set first and second shot' do
          expect(frame.shots[0].score).to eq 1
          expect(frame.shots[1].score).to eq 9
        end
      end
    end
  end

  describe 'full?' do
    let!(:frame) { Frame.new }
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
    let!(:frame) { Frame.new }
    subject { frame.strike? }

    context 'when first shot is X' do
      before do
        frame.set(Shot.new('X'))
      end

      it { is_expected.to be true }
    end
    context 'when first shot is 1 and second shot is 9' do
      before do
        frame.set(Shot.new('1'))
        frame.set(Shot.new('9'))
      end

      it { is_expected.to be false }
    end
  end

  describe 'spare?' do
    let(:frame) { Frame.new }
    subject { frame.spare? }

    context 'when first shot is X' do
      before do
        frame.set(Shot.new('X'))
      end

      it { is_expected.to be false }
    end
    context 'when first shot is 1 and second shot is 9' do
      before do
        frame.set(Shot.new('1'))
        frame.set(Shot.new('9'))
      end

      it { is_expected.to be true }
    end
  end
end

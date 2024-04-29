# frozen_string_literal: true

require_relative '../class/shot'

describe Shot do
  describe 'score' do
    subject do
      shot = Shot.new(mark)
      shot.score
    end

    context "when mark is 'X'" do
      let(:mark) { 'X' }

      it 'return 10' do
        is_expected.to eq 10
      end
    end

    context "when mark is lower case 'x'" do
      let(:mark) { 'x' }

      it 'return 10 (case insensitive)' do
        is_expected.to eq 10
      end
    end

    context "when mark is '11'" do
      let(:mark) { '11' }

      it 'return exception' do
        expect { subject }.to raise_error 'Invalid mark'
      end
    end

    context "when mark is '10'" do
      let(:mark) { '10' }

      it 'return 10' do
        is_expected.to eq 10
      end
    end

    context 'when mark is integer 10' do
      let(:mark) { 10 }

      it 'return 10' do
        is_expected.to eq 10
      end
    end

    context "when mark is '0'" do
      let(:mark) { '0' }

      it 'return 0' do
        is_expected.to eq 0
      end
    end

    context "when mark is '-1'" do
      let(:mark) { '-1' }

      it 'return exception' do
        expect { subject }.to raise_error 'Invalid mark'
      end
    end
  end

  describe 'shot_factory' do
    subject { Shot.shot_factory(marks) }

    context 'when 10 frame is spare' do
      let(:marks) { %w[6 3 9 0 0 3 8 2 7 3 X 9 1 8 0 X 6 4 5] }

      it 'return 21 shots' do
        subject
        expect(subject.size).to eq 21
      end
    end

    context 'when 10 frame is not strike or spare' do
      let(:marks) { %w[0 10 1 5 0 0 0 0 X X X 5 1 8 1 0 4] }

      it 'return 21 shots' do
        subject
        expect(subject.size).to eq 20
      end
    end

    context 'when marks all strike' do
      let(:marks) { %w[X X X X X X X X X X X X] }

      it 'return 21 shots' do
        subject
        expect(subject.size).to eq 21
      end
    end
  end
end

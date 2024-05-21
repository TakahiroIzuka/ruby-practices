# frozen_string_literal: true

require_relative '../lib/shot'

describe Shot do
  describe 'score' do
    subject { Shot.new(mark).score }

    context "when mark is 'X'" do
      let(:mark) { 'X' }

      it 'return 10' do
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
end

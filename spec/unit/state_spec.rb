require 'spec_helper'
require 'curp'
require 'state'

RSpec.describe CurpGenerator::State do
  subject { described_class.new(state) }

  describe "#generate" do
    context 'with missing state' do
      let(:state) { nil }

      it 'raises error' do
        expect {
          subject.generate
        }.to raise_error(
          CurpGenerator::State::InvalidCurpArgumentError,
          'Missing birth state argument'
        )
      end
    end

    context 'with valid state' do
      context 'and is a valid mexican state' do
        let(:state) { 'CHIHUAHUA' }

        it 'returns state characters' do
          expect(subject.generate).to eq('CH')
        end

        it 'returns two characters' do
          expect(subject.generate.size).to eq(2)
        end
      end

      context 'and is a valid letter state code' do
        let(:state) { 'OAX' }

        it 'returns state characters' do
          expect(subject.generate).to eq('OC')
        end

        it 'returns two characters' do
          expect(subject.generate.size).to eq(2)
        end
      end

      context 'and composed name' do
        let(:state) { 'CIUDAD DE MEXICO' }

        it 'returns state characters' do
          expect(subject.generate).to eq('DF')
        end

        it 'returns two characters' do
          expect(subject.generate.size).to eq(2)
        end
      end
    end

    context 'when is a foreign location' do
      context 'and is a valid mexican state' do
        let(:state) { 'USA' }

        it 'returns state foreign characters' do
          expect(subject.generate).to eq('NE')
        end

        it 'returns two characters' do
          expect(subject.generate.size).to eq(2)
        end
      end
    end
  end
end

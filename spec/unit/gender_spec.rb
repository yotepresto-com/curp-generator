require 'spec_helper'
require 'curp'
require 'gender'
require 'base'

RSpec.describe CurpGenerator::Gender do
  subject { described_class.new(gender) }

  describe "#generate" do
    context 'with missing gender' do
      let(:gender) { nil }

      it 'raises error' do
        expect {
          subject.generate
        }.to raise_error(
          CurpGenerator::Gender::InvalidCurpArgumentError,
          'Missing gender'
        )
      end
    end

    context 'with invalid gender' do
      let(:gender) { 'wrong' }

      it 'raises error' do
        expect {
          subject.generate
        }.to raise_error(
          CurpGenerator::Gender::InvalidCurpArgumentError,
          'Available gender options are ["male", "hombre", "masculino", "h", "female", "mujer", "femenino", "m"]'
        )
      end
    end

    context 'with valid gender' do
      context 'when is male' do
        let(:gender) { 'male' }

        it 'returns male character' do
          expect(subject.generate).to eq('H')
        end

        it 'returns single character' do
          expect(subject.generate.size).to eq(1)
        end
      end

      context 'when is female' do
        let(:gender) { 'mujer' }

        it 'returns female character' do
          expect(subject.generate).to eq('M')
        end

        it 'returns single character' do
          expect(subject.generate.size).to eq(1)
        end
      end
    end
  end
end

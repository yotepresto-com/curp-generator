require 'date'
require 'spec_helper'
require 'curp_generator/curp'
require 'curp_generator/birth_date'

RSpec.describe CurpGenerator::BirthDate do
  subject { described_class.new(date) }

  describe "#generate" do
    context 'with missing date' do
      let(:date) { nil }

      it 'raises error' do
        expect {
          subject.generate
        }.to raise_error(
          CurpGenerator::BirthDate::InvalidCurpArgumentError,
          'Invalid date format'
        )
      end
    end

    context 'with invalid date' do
      let(:date) { 'This is a string' }

      it 'raises error' do
        expect {
          subject.generate
        }.to raise_error(
          CurpGenerator::BirthDate::InvalidCurpArgumentError,
          'Invalid date format'
        )
      end
    end

    context 'with valid date' do
      let(:date) { DateTime.parse('1989-05-14').to_date }

      it 'returns parsed date' do
        expect(subject.generate).to eq('890514')
      end

      it 'returns valid date length characters' do
        expect(subject.generate.size).to eq(6)
      end
    end
  end

  describe "#homoclave_digit" do
    context 'with invalid date' do
      let(:date) { nil }

      it 'raises error' do
        expect {
          subject.homoclave_digit
        }.to raise_error(
          CurpGenerator::BirthDate::InvalidCurpArgumentError,
          'Invalid date format'
        )
      end
    end

    context 'with valid date' do
      context 'when year is less than 2000' do
        let(:date) { DateTime.parse('1989-05-14').to_date }

        it 'returns zero' do
          expect(subject.homoclave_digit).to eq('0')
        end

        it 'returns single characters' do
          expect(subject.homoclave_digit.size).to eq(1)
        end
      end

      context 'when year is greater than 2000' do
        let(:date) { DateTime.parse('2000-05-14').to_date }

        it 'returns A' do
          expect(subject.homoclave_digit).to eq('A')
        end

        it 'returns single characters' do
          expect(subject.homoclave_digit.size).to eq(1)
        end
      end
    end
  end
end

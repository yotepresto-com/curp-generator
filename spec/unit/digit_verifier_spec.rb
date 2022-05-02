require 'spec_helper'
require 'curp_generator/curp'
require 'curp_generator/digit_verifier'

RSpec.describe CurpGenerator::DigitVerifier do
  subject { described_class.new(partial_curp) }

  describe "#generate" do
    context 'with missing partial curp' do
      let(:partial_curp) { nil }

      it 'raises error' do
        expect {
          subject.generate
        }.to raise_error(
          CurpGenerator::DigitVerifier::InvalidCurpArgumentError,
          'Missing partial curp'
        )
      end
    end

    context 'with partial curp has invalid length' do
      let(:partial_curp) { 'JASD120' }

      it 'raises error' do
        expect {
          subject.generate
        }.to raise_error(
          CurpGenerator::DigitVerifier::InvalidCurpArgumentError,
          'Invalid partial curp size'
        )
      end
    end

    context 'with valid date' do
      let(:partial_curp) { 'EEGG901010HQTSMM9' }

      it 'returns verifier digit' do
        expect(subject.generate).to eq('4')
      end

      it 'returns single character' do
        expect(subject.generate.size).to eq(1)
      end
    end
  end
end

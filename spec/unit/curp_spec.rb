require 'date'
require 'curp'
require 'spec_helper'

RSpec.describe CurpGenerator::Curp do

  describe "#generate" do
    subject { described_class.new(params).generate }

    context 'on missing params' do
      let(:params) do
        {
          first_name: '',
          second_name: 'g',
          first_last_name: 'g',
          second_last_name: 'g',
          gender: 'male',
          birth_date: DateTime.parse('1989-05-14 06:00:00'),
          birth_state: 'MEXICO'
        }
      end

      it 'raises error' do
        expect { subject }.to raise_error(CurpGenerator::Curp::MissingParamError, "Missing first_name")
      end
    end

    context 'when the profile has no vowels' do
      let(:params) do
        {
          first_name: 'g',
          second_name: 'g',
          first_last_name: 'g',
          second_last_name: 'g',
          gender: 'male',
          birth_date: DateTime.parse('1989-05-14 06:00:00'),
          birth_state: 'MEXICO'
        }
      end

      it 'assigns X in vowel position' do
        expect(subject).to eq('GXGG890514HMCGGG04')
      end
    end

    context 'when the profile generates a forbidden word' do
      let(:params) do
        {
          first_name: 'oscar',
          second_name: 'g',
          first_last_name: 'pu',
          second_last_name: 't',
          gender: 'male',
          birth_date: DateTime.parse('1989-05-14 06:00:00'),
          birth_state: 'MEXICO'
        }
      end

      it 'assigns X in second position' do
        expect(subject).to eq('PXTO890514HMCPTS00')
      end
    end

    context 'when last name is a composed' do
      let(:params) do
        {
          first_name: 'oscar',
          second_name: 'g',
          first_last_name: 'de la rosa',
          second_last_name: 'de la madrid',
          gender: 'male',
          birth_date: DateTime.parse('1989-05-14 06:00:00'),
          birth_state: 'MEXICO'
        }
      end

      it 'removes the prefix' do
        expect(subject).to eq('ROMO890514HMCSDS08')
      end
    end

    context 'when profile has not a second last name' do
      let(:params) do
        {
          first_name: 'oscar',
          second_name: nil,
          first_last_name: 'de la rosa',
          gender: 'male',
          birth_date: DateTime.parse('1989-05-14 06:00:00'),
          birth_state: 'MEXICO'
        }
      end

      it 'adds an X in position' do
        expect(subject).to eq('ROXO890514HMCSXS02')
      end
    end

    context 'when the first last name is a common name' do
      let(:params) do
        {
          first_name: 'maria',
          second_name: 'alejandra',
          first_last_name: 'de la rosa',
          second_last_name: 'Ruiz',
          gender: 'female',
          birth_date: DateTime.parse('1989-10-14 06:00:00'),
          birth_state: 'JALISCO'
        }
      end

      it 'uses the second name' do
        expect(subject).to eq('RORA891014MJCSZL03')
      end
    end
  end
end

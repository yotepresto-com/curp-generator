# require 'curp/parsers/date'
require 'spec_helper'
require 'curp'
require 'name'

RSpec.describe CurpGenerator::Name do
  subject do
    described_class.new(
      first_name,
      second_name,
      first_last_name,
      second_last_name
    )
  end

  describe '#prefix_name' do
    context 'invalid params' do
      context 'with missing first name' do
        let(:first_name) { nil }
        let(:second_name) { nil }
        let(:first_last_name) { nil }
        let(:second_last_name) { nil }

        it 'raises error' do
          expect {
            subject.prefix_name
          }.to raise_error(
            CurpGenerator::Name::InvalidCurpArgumentError,
            'Invalid name arguments'
          )
        end
      end

      context 'with missing first last name' do
        let(:first_name) { 'Diego' }
        let(:second_name) { nil }
        let(:first_last_name) { nil }
        let(:second_last_name) { nil }

        it 'raises error' do
          expect {
            subject.prefix_name
          }.to raise_error(
            CurpGenerator::Name::InvalidCurpArgumentError,
            'Invalid name arguments'
          )
        end
      end
    end

    context 'with valid params' do
      context 'on regular values' do
        let(:first_name) { 'Homer' }
        let(:second_name) { 'Jay' }
        let(:first_last_name) { 'Simpson' }
        let(:second_last_name) { 'Bob' }

        it 'returns prefix characters' do
          expect(subject.prefix_name).to eq('SIBH')
        end

        it 'returns first four characters' do
          expect(subject.prefix_name.size).to eq(4)
        end
      end

      context 'when forbidden word is generated' do
        let(:first_name) { 'Ofelia' }
        let(:second_name) { nil }
        let(:first_last_name) { 'Pedredo' }
        let(:second_last_name) { 'Domínguez' }

        it 'replaces X in second position' do
          expect(subject.prefix_name).to eq('PXDO')
        end
      end

      context 'when first characters is Ñ' do
        let(:first_name) { 'ALBERTO' }
        let(:second_name) { nil }
        let(:first_last_name) { 'ÑANDO' }
        let(:second_last_name) { 'RODRIGUEZ' }

        it 'replaces Ñ for X' do
          expect(subject.prefix_name).to eq('XARA')
        end
      end

      context 'when first characters is Ñ' do
        let(:first_name) { 'MARIA' }
        let(:second_name) { 'LUISA' }
        let(:first_last_name) { 'PEREZ' }
        let(:second_last_name) { 'HERNANDEZ' }

        it 'replaces Ñ for X' do
          expect(subject.prefix_name).to eq('PEHL')
        end
      end

      context 'when is a composed name' do
        context 'and is not a common name' do
          let(:first_name) { 'LUIS' }
          let(:second_name) { 'ENRIQUE' }
          let(:first_last_name) { 'ROMERO' }
          let(:second_last_name) { 'PALAZUELOS' }

          it 'uses first name' do
            expect(subject.prefix_name).to eq('ROPL')
          end
        end

        context 'and is a common name' do
          let(:first_name) { 'MARIA' }
          let(:second_name) { 'LUISA' }
          let(:first_last_name) { 'PEREZ' }
          let(:second_last_name) { 'HERNANDEZ' }

          it 'uses second name' do
            expect(subject.prefix_name).to eq('PEHL')
          end
        end

        context 'and last names contains two words, use first word' do
          let(:first_name) { 'Rocio' }
          let(:second_name) { nil }
          let(:first_last_name) { 'Riva Palacio' }
          let(:second_last_name) { 'Cruz' }

          it 'uses second name' do
            expect(subject.prefix_name).to eq('RICR')
          end
        end

        context 'and names or last names contains prepositions' do
          let(:first_name) { 'Carlos' }
          let(:second_name) { nil }
          let(:first_last_name) { 'MC Gregor' }
          let(:second_last_name) { 'Lopez' }

          it 'skip preposition' do
            expect(subject.prefix_name).to eq('GELC')
          end
        end
      end

      context 'when name contains special characters in vowels' do
        let(:first_name) { 'MARIA' }
        let(:second_name) { 'LUISA' }
        let(:first_last_name) { 'ÁRGÜELLO' }
        let(:second_last_name) { 'RODRIGUEZ' }

        it 'clears vowels' do
          expect(subject.prefix_name).to eq('AURL')
        end
      end

      context 'when first last name does not contains internal vowels' do
        let(:first_name) { 'ANDRES' }
        let(:second_name) { '' }
        let(:first_last_name) { 'ICH' }
        let(:second_last_name) { 'RODRÍGUEZ' }

        it 'assigns X in second position' do
          expect(subject.prefix_name).to eq('IXRA')
        end
      end

      context 'when does not contains second last name' do
        let(:first_name) { 'Luis' }
        let(:second_name) { '' }
        let(:first_last_name) { 'PËREZ' }
        let(:second_last_name) { nil }

        it 'assigns X in third position' do
          expect(subject.prefix_name).to eq('PEXL')
        end
      end
    end
  end

  describe '#sufix_name' do
    context 'invalid params' do
      context 'with missing first name' do
        let(:first_name) { nil }
        let(:second_name) { nil }
        let(:first_last_name) { nil }
        let(:second_last_name) { nil }

        it 'raises error' do
          expect {
            subject.sufix_name
          }.to raise_error(
            CurpGenerator::Name::InvalidCurpArgumentError,
            'Invalid name arguments'
          )
        end
      end

      context 'with missing first last name' do
        let(:first_name) { 'Diego' }
        let(:second_name) { nil }
        let(:first_last_name) { nil }
        let(:second_last_name) { nil }

        it 'raises error' do
          expect {
            subject.sufix_name
          }.to raise_error(
            CurpGenerator::Name::InvalidCurpArgumentError,
            'Invalid name arguments'
          )
        end
      end
    end

    context 'with valid params' do
      context 'when internal consonant is Ñ' do
        let(:first_name) { 'Juan' }
        let(:second_name) { 'Carlos' }
        let(:first_last_name) { 'Estebes' }
        let(:second_last_name) { 'Gonzalez' }

        it 'returns internal consontants' do
          expect(subject.sufix_name).to eq('SNN')
        end

        it 'returns three characters' do
          expect(subject.sufix_name.size).to eq(3)
        end
      end

      context 'when internal consonant is Ñ' do
        let(:first_name) { 'Alberto' }
        let(:second_name) { nil }
        let(:first_last_name) { 'Oñante' }
        let(:second_last_name) { 'Rodriguez' }

        it 'replaces X in first position' do
          expect(subject.sufix_name).to eq('XDL')
        end
      end

      context 'when internal consonants does not exist' do
        let(:first_name) { 'Andres' }
        let(:second_name) { nil }
        let(:first_last_name) { 'Po' }
        let(:second_last_name) { 'Barrios' }

        it 'assigns X' do
          expect(subject.sufix_name).to eq('XRN')
        end
      end

      context 'when only has one last name' do
        let(:first_name) { 'Leticia' }
        let(:second_name) { nil }
        let(:first_last_name) { 'Luna' }
        let(:second_last_name) { nil }

        it 'assigns X' do
          expect(subject.sufix_name).to eq('NXT')
        end
      end

      context 'when has composed name' do
        let(:first_name) { 'Ma.' }
        let(:second_name) { 'De los Angeles' }
        let(:first_last_name) { 'Moreno' }
        let(:second_last_name) { 'Sanchez' }

        it 'uses internal consonants of second word' do
          expect(subject.sufix_name).to eq('RNN')
        end
      end
    end
  end
end

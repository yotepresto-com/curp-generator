require 'date'
require 'spec_helper'
require 'curp_generator/curp'

RSpec.describe CurpGenerator::Curp do
  describe "#generate" do
    subject { described_class.new(params).generate }

    context 'on missing params' do
      let(:params) do
        {
          first_name:       '',
          second_name:      'g',
          first_last_name:  'g',
          second_last_name: 'g',
          gender:           'male',
          birth_date:       DateTime.parse('1989-05-14 06:00:00'),
          birth_state:      'MEXICO'
        }
      end

      it 'raises error' do
        expect { subject }.to raise_error(CurpGenerator::Curp::InvalidArgumentError, 'Missing first name')
      end
    end

    context 'on valid params' do
      let(:params) do
        {
          first_name:       'Juan',
          second_name:      'Carlos',
          first_last_name:  'Estebes',
          second_last_name: 'Gonzalez',
          gender:           'hombre',
          birth_date:       DateTime.parse('1990-01-01 06:00:00'),
          birth_state:      'MEXICO'
        }
      end

      it 'contains prefix name characters on positions 0..3' do
        expect(subject[0..3]).to eq('EEGJ')
      end

      it 'contains birthdate characters in positions 4..9' do
        expect(subject[4..9]).to eq('900101')
      end

      it 'contains gender character in position 10' do
        expect(subject[10]).to eq('H')
      end

      it 'contains state characters in positions 11..12' do
        expect(subject[11..12]).to eq('MC')
      end

      it 'contains sufix name characters in positions 13..15' do
        expect(subject[13..15]).to eq('SNN')
      end

      it 'contains homoclave digit in positions 16' do
        expect(subject[16]).to eq('0')
      end

      it 'contains verifier digit in positions 17' do
        expect(subject[17]).to eq('5')
      end

      it 'generates a valid CURP' do
        expect(subject).to eq('EEGJ900101HMCSNN05')
      end

      it 'returns a 18 string length' do
        expect(subject.size).to eq(18)
      end

      context 'and special use cases' do
        context 'first elements of name' do
          context 'when first_name has Ñ character' do
            let(:params) do
              {
                first_name:       'Alberto',
                second_name:      '',
                first_last_name:  'Ñando',
                second_last_name: 'Rodríguez',
                gender:           'female',
                birth_date:       DateTime.parse('1989-02-16 06:00:00'),
                birth_state:      'MEXICO'
              }
            end

            it 'replaces Ñ by X' do
              expect(subject).to eq('XARA890216MMCNDL03')
            end
          end

          context 'when last name is a composed' do
            let(:params) do
              {
                first_name:       'oscar',
                second_name:      'g',
                first_last_name:  'De la Rosa',
                second_last_name: 'De la madrid',
                gender:           'male',
                birth_date:       DateTime.parse('1999-10-10 06:00:00'),
                birth_state:      'MEXICO'
              }
            end

            it 'removes prefix' do
              expect(subject).to eq('ROMO991010HMCSDS03')
            end
          end

          context 'when first last name has a space between characters' do
            let(:params) do
              {
                first_name:       'Luis',
                second_name:      'Paulo',
                first_last_name:  first_last_name,
                second_last_name: 'Cabrera',
                gender:           'male',
                birth_date:       DateTime.parse('2003-10-02 06:00:00'),
                birth_state:      'GUANAJUATO'
              }
            end

            let(:first_last_name) { nil }

            context "but with a space after the apostrophe" do
              let(:first_last_name) { "D' Acosta" }

              it 'assigns X in second position' do
                expect(subject).to eq('DXCL031002HGTXBSA3')
              end
            end

            context "but without a space" do
              let(:first_last_name) { "D'Acosta" }

              it 'generates curp' do
                expect(subject).to eq('DACL031002HGTCBSA1')
              end
            end
          end

          context 'when name contains different non alphabetic characters' do
            let(:params) do
              {
                first_name:       'Luis',
                second_name:      '',
                first_last_name:  'Arguello',
                second_last_name: 'De la madrid',
                gender:           'male',
                birth_date:       DateTime.parse('1999-10-10 06:00:00'),
                birth_state:      'MEXICO'
              }
            end

            it 'generates curps without special characters' do
              expect(subject).to eq('AUML991010HMCRDS00')
            end
          end

          context 'when composed last names' do
            let(:params) do
              {
                first_name:       'Rocio',
                second_name:      '',
                first_last_name:  'Riva Palacio',
                second_last_name: 'Cruz',
                gender:           'female',
                birth_date:       DateTime.parse('1999-10-10 06:00:00'),
                birth_state:      'MEXICO'
              }
            end

            it 'generates curp using first word of composed last name' do
              expect(subject).to eq('RICR991010MMCVRC03')
            end
          end

          context 'when profile could generate a bad word' do
            let(:params) do
              {
                first_name:       'Oscar',
                second_name:      'g',
                first_last_name:  'Pudencio',
                second_last_name: 'Tomas',
                gender:           'male',
                birth_date:       DateTime.parse('1999-10-10 06:00:00'),
                birth_state:      'MEXICO'
              }
            end

            it 'assigns X in second position' do
              expect(subject).to eq('PXTO991010HMCDMS02')
            end
          end

          context 'when first last name does not contain internal vowels' do
            let(:params) do
              {
                first_name:       'ANDRES',
                second_name:      '',
                first_last_name:  'ICH',
                second_last_name: 'RODRÍGUEZ',
                gender:           'male',
                birth_date:       DateTime.parse('1999-10-10 06:00:00'),
                birth_state:      'MEXICO'
              }
            end

            it 'assigns X in second character position' do
              expect(subject).to eq('IXRA991010HMCCDN02')
            end
          end

          context 'when user hasnt second_last_name' do
            let(:params) do
              {
                first_name:       'LUIS',
                second_name:      '',
                first_last_name:  'PEREZ',
                second_last_name: nil,
                gender:           'male',
                birth_date:       DateTime.parse('1999-10-10 06:00:00'),
                birth_state:      'MEXICO'
              }
            end

            it 'add an X in third position' do
              expect(subject).to eq('PEXL991010HMCRXS05')
            end
          end

          context 'when first last name is a common name' do
            let(:params) do
              {
                first_name:       'maria',
                second_name:      'Inez',
                first_last_name:  'de la rosa',
                second_last_name: 'ruiz',
                gender:           'female',
                birth_date:       DateTime.parse('1989-05-14 06:00:00'),
                birth_state:      'MEXICO'
              }
            end

            it 'uses second name' do
              expect(subject).to eq('RORI890514MMCSZN03')
            end
          end

          context "when first_name is Jose and second_name is composed name" do
            let(:params) do
              {
                first_name:       'Jose',
                second_name:      'De Jesus',
                first_last_name:  'Rojas',
                second_last_name: 'Flores',
                gender:           'male',
                birth_date:       DateTime.parse('1999-10-10 06:00:00'),
                birth_state:      'JALISCO'
              }
            end

            it 'returns curp using second name first constant' do
              expect(subject).to eq('ROFJ991010HJCJLS04')
            end
          end
        end

        context 'state name use case' do
          context 'when state has a composed name' do
            let(:params) do
              {
                first_name:       'maria',
                second_name:      'alejandra',
                first_last_name:  'de la rosa',
                second_last_name: 'Ruiz',
                gender:           'female',
                birth_date:       DateTime.parse('1989-05-14 06:00:00'),
                birth_state:      'CDMX'
              }
            end

            it 'parse information correctly for curp' do
              expect(subject).to eq('RORA890514MDFSZL04')
            end
          end
        end

        context 'consonants cases' do
          context "when first_name has Ñ character for intern consonant" do
            let(:params) do
              {
                first_name:       'Ilse',
                second_name:      'Pamela',
                first_last_name:  'Nuñez',
                second_last_name: 'Hernandez',
                gender:           'female',
                birth_date:       DateTime.parse('1989-02-16 06:00:00'),
                birth_state:      'MEXICO'
              }
            end

            it 'replaces Ñ by X' do
              expect(subject).to eq('NUHI890216MMCXRL05')
            end
          end

          context "when does not exist internal consonants" do
            let(:params) do
              {
                first_name:       'ANDRES',
                second_name:      '',
                first_last_name:  'Po',
                second_last_name: 'Barrios',
                gender:           'male',
                birth_date:       DateTime.parse('1999-10-10 06:00:00'),
                birth_state:      'JALISCO'
              }
            end

            it 'assings X in internal position' do
              expect(subject).to eq('POBA991010HJCXRN04')
            end
          end

          context "when there is only one last_name" do
            let(:params) do
              {
                first_name:       'LETICIA',
                second_name:      '',
                first_last_name:  'LUNA',
                second_last_name: '',
                gender:           'FEMALE',
                birth_date:       DateTime.parse('1999-10-10 06:00:00'),
                birth_state:      'JALISCO'
              }
            end

            it 'assings X in position 15' do
              expect(subject).to eq('LUXL991010MJCNXT09')
            end
          end

          context "when composed name" do
            let(:params) do
              {
                first_name:       'MARIA',
                second_name:      'DE LOS ANGELES',
                first_last_name:  'MORENO',
                second_last_name: 'SANCHEZ',
                gender:           'm',
                birth_date:       DateTime.parse('1999-10-10 06:00:00'),
                birth_state:      'JALISCO'
              }
            end

            it 'uses second word for internal consonants' do
              expect(subject).to eq('MOSA991010MJCRNN08')
            end
          end
        end
      end
    end
  end
end

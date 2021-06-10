require 'rails_helper'

RSpec.describe Patient, type: :model do
  subject {
    described_class.new(name: 'Joe', cpf: '12345678901', birth_date: Time.now)
  }

  describe 'Relationships' do
    it 'has many appointments' do
      should respond_to(:appointments)
    end

    it 'has many doctors through appointments' do
      should respond_to(:doctors)
    end
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without name' do
      subject.name = ''
      expect(subject).to_not be_valid
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without cpf' do
      subject.cpf = ''
      expect(subject).to_not be_valid
      subject.cpf = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without birth date' do
      subject.birth_date = ''
      expect(subject).to_not be_valid
      subject.birth_date = nil
      expect(subject).to_not be_valid
    end

    context 'when cpf is not unique' do
      before { described_class.create!(name: 'Joe', cpf: '12345678901', birth_date: "01/03/2000") }
      it 'is invalid if cpf is not unique' do
        expect(subject).to be_invalid
      end
    end

    context 'when cpf has invalid format' do
      it 'is invalid when cpf has more than 11 characters' do
        subject.cpf = '1234567890123'
        expect(subject).to_not be_valid
      end

      it 'is invalid when cpf has less than 11 characters' do
        subject.cpf = '123456133'
        expect(subject).to_not be_valid
      end

      it 'is invalid when cpf has exact 11 characters but not all numbers' do
        subject.cpf = 'aaddsseeff3'.to_i
        expect(subject).to_not be_valid
      end

      it 'is valid when cpf has exact 11 characters that are numbers' do
        subject.cpf = '12345678901'.to_i
        expect(subject).to be_valid
      end
    end
  end
end

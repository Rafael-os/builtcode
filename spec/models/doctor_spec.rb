require 'rails_helper'

RSpec.describe Doctor, type: :model do
  subject {
    described_class.new(name: 'Strange', crm: '1234', crm_uf: "SP")
  }

  describe 'Relationships' do
    it 'has many appointments' do
      should respond_to(:appointments)
    end

    it 'has many patients through appointments' do
      should respond_to(:patients)
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

    it 'is not valid without crm' do
      subject.crm = ''
      expect(subject).to_not be_valid
      subject.crm = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without crm_uf' do
      subject.crm_uf = ''
      expect(subject).to_not be_valid
      subject.crm_uf = nil
      expect(subject).to_not be_valid
    end
  
    context 'when crm is not unique' do
      before { described_class.create!(name: 'Strange', crm: '1234', crm_uf: 'SP') }
      it 'is invalid if CRM is not unique' do
        expect(subject).to_not be_valid
      end
    end

    context 'when crm number is the same but crm_uf is different' do
      before { described_class.create!(name: 'Strange', crm: '1234', crm_uf: 'PR') }
      it 'is valid if CRM share same number but different crm_uf' do
        expect(subject).to be_valid
      end
    end

    context 'when crm number is different but crm_uf is the same' do
      before { described_class.create!(name: 'Strange', crm: '4321', crm_uf: 'SP') }
      it 'is valid if CRM have different number but same crm_uf' do
        expect(subject).to be_valid
      end
    end
  end
end

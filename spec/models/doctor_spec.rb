require 'rails_helper'

RSpec.describe Doctor, type: :model do
  describe 'validation' do
    it 'has a name' do
      doctor = Doctor.new(
        name: "",
        crm: "A valid CRM",
        crm_uf: "A valid UF"
      )
      expect(doctor).to_not be_valid
      doctor.name = "Strange"
      expect(doctor).to be_valid
    end
  
    it 'has a crm' do
      doctor = Doctor.new(
        name: "Strange",
        crm: "",
        crm_uf: "A valid UF"
      )
      expect(doctor).to_not be_valid
      doctor.crm = "3213"
      expect(doctor).to be_valid
    end
    
    it 'has a crm_uf' do
      doctor = Doctor.new(
        name: "Strange",
        crm: "1232",
        crm_uf: ""
      )
      expect(doctor).to_not be_valid
      doctor.crm_uf = "SP"
      expect(doctor).to be_valid
    end
  
    context 'when CRM is not unique' do
      before { described_class.create!(name: 'Strange', crm: '1234', crm_uf: 'SP') }
    end
  end
end

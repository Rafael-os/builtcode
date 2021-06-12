require 'rails_helper'
require 'date'

RSpec.describe Appointment, type: :model do
  let(:doctor) { Doctor.create(name: 'Strange', crm: '1234', crm_uf: "SP") }
  let(:patient) { Patient.create(name: 'Joe', cpf: '12345678901', birth_date: Time.now) }

  subject {
    described_class.new(starts_at: DateTime.new(2021, 6, 20, 9), ends_at: DateTime.new(2021, 6, 20, 9, 9.5), patient_id: patient.id, doctor_id: doctor.id)
  }

  describe 'Relationships' do
    it 'belongs to doctor' do
      should respond_to(:doctor)
    end

    it 'belongs to patients' do
      should respond_to(:patient)
    end
  end

  context 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end
  end

end

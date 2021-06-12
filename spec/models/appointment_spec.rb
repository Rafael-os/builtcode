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

  context 'Time constraints' do
    it 'cannot schedule for past dates' do
      subject.starts_at = DateTime.now
      expect(subject.starts_at.day - 1).to be_invalid
    end

    it 'cannot shcedule for past hours' do
      subject.starts_at = DateTime.now
      expect(subject.starts_at.hour - 1).to be_invalid
    end

    it 'cannot be earlier than 9 am' do
      schedule_time = DateTime.new(2021,6,20,8)
      subject.starts_at = schedule_time
      expect(subject.starts_at.hour).to be_invalid
    end

    it 'cannot be later than 18' do
      schedule_time = DateTime.new(2021,6,20,19)
      subject.starts_at = schedule_time
      expect(subject.starts_at.hour).to be_invalid
    end

    it 'cannot be schedule during lunch break' do
      schedule_time = DateTime.new(2021,6,20,12)
      subject.starts_at = schedule_time
      expect(subject.starts_at.hour).to be_invalid
    end
  end

end

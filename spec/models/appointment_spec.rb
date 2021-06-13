require 'rails_helper'
require 'date'

RSpec.describe Appointment, type: :model do
  let(:doctor) { Doctor.create(name: 'Strange', crm: '1234', crm_uf: "SP") }
  let(:patient) { Patient.create(name: 'Joe', cpf: '12345678901', birth_date: Time.now) }

  subject {
    described_class.new(starts_at: DateTime.new(2022, 6, 20, 9), ends_at: DateTime.new(2022, 6, 20, 9, 30), patient_id: patient.id, doctor_id: doctor.id)
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

    it 'cannot create without starting date' do
      subject.starts_at = nil
      expect(subject).to_not be_valid
    end

    it 'cannot create without ending date' do
      subject.ends_at = nil
      expect(subject).to_not be_valid
    end
  end

  context 'Time constraints' do
    it 'cannot schedule for past dates' do
      subject.starts_at = DateTime.now - 1
      expect(subject).to_not be_valid
    end

    it 'cannot be earlier than 9 am' do
      schedule_time = DateTime.new(2021,6,20,8)
      subject.starts_at = schedule_time
      expect(subject).to_not be_valid
    end

    it 'cannot be later than 18' do
      schedule_time = DateTime.new(2021,6,20,19)
      subject.starts_at = schedule_time
      expect(subject).to_not be_valid
    end

    it 'cannot be schedule during lunch break' do
      schedule_time = DateTime.new(2021,6,20,12)
      subject.starts_at = schedule_time
      expect(subject).to_not be_valid
    end

    it 'can last 30 minutes' do
      schedule_time = Time.new(2021,6,20,13)
      finish_time = schedule_time + 1800
      subject.starts_at = schedule_time
      subject.ends_at = finish_time
      expect(subject).to be_valid
    end

    it 'cannot last more than 30 minutes' do
      schedule_time = Time.new(2021,6,20,13)
      finish_time = schedule_time + 1801
      subject.starts_at = schedule_time
      subject.ends_at = finish_time
      expect(subject).to_not be_valid
    end
  end

end

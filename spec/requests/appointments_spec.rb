require 'rails_helper'

RSpec.describe "Doctors", type: :request do
  doctor = Doctor.create!(name: 'Strange', crm: '1234', crm_uf: "SP")
  patient = Patient.create!(name: 'Paciente', birth_date: '1990/01/01', cpf: "12345678901")

  let(:valid_attributes) do {
    starts_at: DateTime.now + 10,
    ends_at: DateTime.now + 10.01,
    patient_id: patient.id,
    doctor_id: doctor.id
    }
  end

  let(:invalid_attributes) do {
    starts_at: DateTime.now - 1,
    ends_at: DateTime.now,
    patient_id: patient.id,
    doctor_id: doctor.id
  }
  end

  describe "GET /index" do
    before(:each) { get appointments_path }
    it "is success" do
      expect(response).to have_http_status(200)
    end

    it "render index template" do
      expect(response).to render_template('index')
    end

    it "assigns all appointments to @appointments" do
      expect(assigns(:appointments)).to eq(Appointment.all)
    end
  end

  describe "POST /create" do
    context 'with valid parameters' do 
      it 'checks redirect status' do
        get appointments_url, params: { appointment: valid_attributes }
        expect(response).to be_successful
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new doctor' do
        expect do
          post doctors_url, params: { doctor: invalid_attributes }
        end.to change(Doctor, :count).by(0)
      end

      it "renders 'new' template)" do
        post doctors_url, params: { doctor: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  # describe 'GET /new' do
  #   it "renders :new template" do
  #     get appointment_path
  #     expect(response).to be_successful
  #   end
  # end

  # describe 'GET /edit' do
  #   it 'renders a successful response' do
  #     appointment = Appointment.new(valid_attributes)
  #     appointment.save
  #     get edit_appointment_url(appointment)
  #     expect(response).to be_successful
  #   end
  # end

  # describe 'PATCH /update' do
  #   context 'with valid parameters' do
  #     let(:new_attributes) do
  #       {
  #         'id' => '1',
  #         'starts_at' => 'DateTime.now + 1',
  #         'ends_at' => 'DateTime.now + 1.01',
  #         'patient_id' => 'patient.id',
  #         'doctor_id' => 'doctor.id'
  #       }
  #     end

  #     it 'updates the requested post' do
  #       appointment = Appointment.new(valid_attributes)
  #       appointment.save
  #       patch appointment_url(appointment), params: { appointment: new_attributes }
  #       appointment.reload
  #     end

  #     it 'redirects to /appointments' do
  #       appointment = Appointment.new(valid_attributes)
  #       appointment.save
  #       patch appointment_url(appointment), params: { appointment: new_attributes }
  #       appointment.reload
  #       expect(response).to redirect_to(appointments_url)
  #     end
  #   end

  #   context 'with invalid parameters' do
  #     it "renders 'edit' template" do
  #       appointment = Appointment.create! valid_attributes
  #       patch appointment_url(appointment), params: { appointment: invalid_attributes }
  #       expect(response).to be_successful
  #     end
  #   end
  # end

  # describe 'DELETE /destroy' do
  #   it 'destroys the requested post' do
  #     appointment = Appointment.new(valid_attributes)
  #     appointment.save
  #     expect do
  #       delete appointment_url(appointment)
  #     end.to change(Appointment, :count).by(-1)
  #   end

  #   it 'redirects to appointments list' do
  #     appointment = Appointment.new(valid_attributes)
  #     appointment.save
  #     delete appointment_url(appointment)
  #     expect(response).to redirect_to(appointments_url)
  #   end
  # end

end

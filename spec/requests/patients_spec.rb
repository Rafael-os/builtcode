require 'rails_helper'

RSpec.describe "Patients", type: :request do
  let(:valid_attributes) do {
    name: 'Maria', 
    birth_date: '1990/01/01',
    cpf: "12345678901"
  }
  end

  let(:invalid_attributes) do {
    name: '', 
    birth_date: '1990/01/01',
    cpf: "12345678901"
  }
  end

  describe "GET /index" do
    before(:each) { get patients_path }
    it "is success" do
      expect(response).to have_http_status(200)
    end

    it "render index template" do
      expect(response).to render_template('index')
    end

    it "assigns all patients to @patients" do
      expect(assigns(:patients)).to eq(Patient.all)
    end
  end

  describe "POST /create" do
    context 'with valid parameters' do
      it 'creates a new patient' do
        expect do
          patient = Patient.new(valid_attributes)
          patient.save
          post patients_url, params: { patient: valid_attributes }
        end.to change(Patient, :count).by(1)
      end

      it 'checks redirect status' do
        get patients_url, params: { patient: valid_attributes }
        expect(response).to be_successful
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new patient' do
        expect do
          post patients_url, params: { patient: invalid_attributes }
        end.to change(Patient, :count).by(0)
      end

      it "renders 'new' template" do
        post patients_url, params: { patient: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'GET /new' do
    it "renders :new template" do
      get new_patient_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      patient = Patient.new(valid_attributes)
      patient.save
      get edit_patient_url(patient)
      expect(response).to be_successful
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          'id' => '1',
          'name' => 'Person',
          'birth_date' => '2000/01/01',
          'cpf' => '12332112332'
        }
      end

      it 'updates the requested post' do
        patient = Patient.new(valid_attributes)
        patient.save
        patch patient_url(patient), params: { patient: new_attributes }
        patient.reload
      end

      it 'redirects to /patients' do
        patient = Patient.new(valid_attributes)
        patient.save
        patch patient_url(patient), params: { patient: new_attributes }
        patient.reload
        expect(response).to redirect_to(patients_url)
      end
    end

    context 'with invalid parameters' do
      it "renders 'edit' template" do
        patient = Patient.create! valid_attributes
        patch patient_url(patient), params: { patient: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested post' do
      patient = Patient.new(valid_attributes)
      patient.save
      expect do
        delete patient_url(patient)
      end.to change(Patient, :count).by(-1)
    end

    it 'redirects to patients list' do
      patient = Patient.new(valid_attributes)
      patient.save
      delete patient_url(patient)
      expect(response).to redirect_to(patients_url)
    end
  end

end

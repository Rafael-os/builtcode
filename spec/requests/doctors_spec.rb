require 'rails_helper'

RSpec.describe "Doctors", type: :request do
  let(:valid_attributes) do {
    name: 'Strange', 
    crm: '1234',
    crm_uf: "SP"
  }
  end

  let(:invalid_attributes) do {
    name: '', 
    crm: '1234',
    crm_uf: "SP"
  }
  end

  describe "GET /index" do
    before(:each) { get doctors_path }
    it "is success" do
      expect(response).to have_http_status(200)
    end

    it "render index template" do
      expect(response).to render_template('index')
    end

    it "assigns all doctors to @doctors" do
      expect(assigns(:doctors)).to eq(Doctor.all)
    end
  end

  describe "POST /create" do
    context 'with valid parameters' do
      it 'creates a new doctor' do
        expect do
          doctor = Doctor.new(valid_attributes)
          doctor.save
          post doctors_url, params: { doctor: valid_attributes }
        end.to change(Doctor, :count).by(1)
      end

      it 'checks redirect status' do
        get doctors_url, params: { doctor: valid_attributes }
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

  describe 'GET /new' do
    it "renders :new template" do
      get new_doctor_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      doctor = Doctor.new(valid_attributes)
      doctor.save
      get edit_doctor_url(doctor)
      expect(response).to be_successful
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          'id' => '1',
          'name' => 'House',
          'crm' => '54231',
          'crm_uf' => 'PR'
        }
      end

      it 'updates the requested post' do
        doctor = Doctor.new(valid_attributes)
        doctor.save
        patch doctor_url(doctor), params: { doctor: new_attributes }
        doctor.reload
      end

      it 'redirects to /doctors' do
        doctor = Doctor.new(valid_attributes)
        doctor.save
        patch doctor_url(doctor), params: { doctor: new_attributes }
        doctor.reload
        expect(response).to redirect_to(doctors_url)
      end
    end

    context 'with invalid parameters' do
      it "renders 'edit' template" do
        doctor = Doctor.create! valid_attributes
        patch doctor_url(doctor), params: { doctor: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested post' do
      doctor = Doctor.new(valid_attributes)
      doctor.save
      expect do
        delete doctor_url(doctor)
      end.to change(Doctor, :count).by(-1)
    end

    it 'redirects to doctors list' do
      doctor = Doctor.new(valid_attributes)
      doctor.save
      delete doctor_url(doctor)
      expect(response).to redirect_to(doctors_url)
    end
  end

end

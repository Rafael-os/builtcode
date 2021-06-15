require 'rails_helper'
require 'date'

RSpec.describe "patients/edit.html.erb", type: :view do
  before(:each) do
    patient = assign(:patient, Patient.create!(
      name: "Patient 1",
      birth_date: "1990/01/01",
      cpf: "12345678901"
    ))
  end
  # let(:patient) do {
  #   name: 'Patient1', 
  #   birth_date: "1990/01/01",
  #   cpf: "12345665432"
  #   }
  # end

  # before do
  #   assign(:patient, patient)
  #   render
  # end

  it "renders the edit patient form" do
    render

    assert_select "form[action=?][method=?]", patient_url(patient), "post" do
    
        assert_select "input[name=?]", "patient[name]"

        assert_select "input[name=?]", "patient[birth_date]"

        assert_select "input[name=?]", "patient[cpf]"

    end
  end
end

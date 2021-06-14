require 'rails_helper'

RSpec.describe "patients/edit.html.erb", type: :view do
  before(:each) do
    @patient = assign(:patient, Patient.create!(
      name: "Patient 1",
      birth_date: Date.today,
      cpf: "12345678901"
    ))
  end

  it "renders the edit patient form" do
    render

    assert_select "form[action=?][method=?]", patient_path(@patient), "post" do
    
        assert_select "input[name=?]", "patient[name]"

        assert_select "input[name=?]", "patient[birth_date]"

        assert_select "input[name=?]", "patient[cpf]"

    end
  end
end

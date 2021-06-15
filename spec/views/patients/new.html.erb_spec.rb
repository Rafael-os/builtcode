require 'rails_helper'
require 'date'

RSpec.describe "patients/new.html.erb", type: :view do
  before(:each) do
    @patient = assign(:patient, Patient.create!(
      name: "Patient 1",
      birth_date: (Date.today - 1).strftime("%Y/%m/%d"),
      cpf: "12345678901"
    ))
  end

  it "renders the new patient form" do
    render

    assert_select "form[action=?][method=?]", patient_path(@patient), "post" do
    
        assert_select "input[name=?]", "patient[name]"

        assert_select "input[name=?]", "patient[cpf]"

    end
  end
end

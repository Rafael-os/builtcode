require 'rails_helper'

RSpec.describe "doctors/edit.html.erb", type: :view do
  before(:each) do
    @doctor = assign(:doctor, Doctor.create!(
      name: "Strange",
      crm: "1234",
      crm_uf: "SP"
    ))
  end

  it "renders the edit doctor form" do
    render

    assert_select "form[action=?][method=?]", doctor_path(@doctor), "post" do
    
        assert_select "input[name=?]", "doctor[name]"

        assert_select "input[name=?]", "doctor[crm]"

    end
  end
end

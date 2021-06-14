require 'rails_helper'

RSpec.describe "doctors/index", type: :view do
  it "display all the doctors" do
    assign(:doctors, [
      Doctor.create!(name: "Strange", crm: "1234", crm_uf: "SP"),
      Doctor.create!(name: "House", crm: "1234", crm_uf: "PR")
    ])

    render

    expect(rendered).to match /Strange/
    expect(rendered).to match /House/
  end
end

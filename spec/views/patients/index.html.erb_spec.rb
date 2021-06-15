require 'rails_helper'

RSpec.describe "patients/index.html.erb", type: :view do
  it "display all the patients" do
    assign(:patients, [
      Patient.create!(name: "Patient", birth_date: "1991/01/01", cpf: "12345678901"),
      Patient.create!(name: "Peter", birth_date: "1991/01/02", cpf: "12345678902")
    ])

    render

    expect(rendered).to match /Patient/
    expect(rendered).to match /Peter/
  end
end

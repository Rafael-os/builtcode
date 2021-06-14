require 'rails_helper'

RSpec.describe "patients/index.html.erb", type: :view do
  it "display all the patients" do
    assign(:patients, [
      Patient.create!(name: "Patient1", birth_date: DateTime.now, cpf: "12345678901"),
      Patient.create!(name: "Patient2", birth_date: DateTime.now, cpf: "12345678902")
    ])

    render

    expect(rendered).to match /Patient1/
    expect(rendered).to match /Patient2/
  end
end

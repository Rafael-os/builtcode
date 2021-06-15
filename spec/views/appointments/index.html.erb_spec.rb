require 'rails_helper'

RSpec.describe "appointments/index.html.erb", type: :view do
  
  it "display all the appointments" do
    doctor1 = Doctor.create!(name: 'Strange', crm: '1234', crm_uf: "SP")
    patient1 = Patient.create!(name: 'Paciente', birth_date: '1990/01/01', cpf: "12345678901")
    doctor2 = Doctor.create!(name: 'House', crm: '1234', crm_uf: "PR")
    patient2 = Patient.create!(name: 'Paciente2', birth_date: '1990/01/05', cpf: "12345675342")
    assign(:appointments, [
      Appointment.create!(starts_at: DateTime.now + 10, ends_at: DateTime.now + 10.01, patient_id: patient1.id, doctor_id: doctor2.id),
      Appointment.create!(starts_at: DateTime.now + 5, ends_at: DateTime.now + 5.01, patient_id: patient2.id, doctor_id: doctor2.id)
    ])

    render

    expect(rendered).to match /1/
    expect(rendered).to match /2/
  end
end

require 'rails_helper'

RSpec.describe "appointments/new.html.erb", type: :view do
  it "renders the new appointment form" do
    doctor1 = Doctor.create(name: 'Strange', crm: '1234', crm_uf: "SP")
    patient1 = Patient.create(name: 'Paciente', birth_date: '1990/01/01', cpf: "12345678901")

    @appointment = assign(:appointment, [
      Appointment.create!(starts_at: DateTime.now + 10, ends_at: DateTime.now + 10.01, patient_id: patient1.id, doctor_id:doctor1.id),
    ])
    render

    assert_select "form[action=?][method=?]", appointment_path(@appointment), "post" do
    
        assert_select "input[type=?]", "submit"

    end
  end
end

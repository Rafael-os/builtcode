class PagesController < ApplicationController

  def dashboard
    @doctors = Doctor.all
    @ordered = @doctors.order(created_at: :desc)
    @finished_appointments = Appointment.where('ends_at < ?', Time.now).count
  end
end
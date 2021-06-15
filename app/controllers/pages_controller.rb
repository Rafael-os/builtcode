class PagesController < ApplicationController

  def dashboard
    @doctors = Doctor.all
    @ordered = @doctors.order(created_at: :desc)
    appointments_done
  end

  def appointments_done
    @finished_appointments = Appointment.where('ends_at < ?', DateTime.now).count
  end
end
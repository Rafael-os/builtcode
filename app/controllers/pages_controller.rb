class PagesController < ApplicationController

  def dashboard
    @doctors = Doctor.all
    @ordered = @doctors.order(created_at: :desc)
    @finished_appointments = Appointment.where('ends_at < ?', Time.now).count
    if params[:search]
      a = params[:search]
      @start = a["start_date"]
      @end = a["end_date"]
      @patients_number = Appointment.where("starts_at between ? and ?", Date.parse(@start).beginning_of_day, Date.parse(@end).end_of_day)
      @patients_number = @patients_number.distinct.count('patient_id')
    end
  end
end
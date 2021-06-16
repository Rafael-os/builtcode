class PagesController < ApplicationController

  def dashboard
    @doctors = Doctor.all
    @ordered = @doctors.order(created_at: :desc)
    @finished_appointments = Appointment.where('ends_at < ?', Time.now).count
    @patients_number = Appointment.where("starts_at between ? and ?", @start_date, @end_date)
    @search = Search.new(params[:search])
    @numbers = @search.scope
  end
end
class Search
  attr_reader :date_from, :date_to

  def initialize(params)
    params ||= {}
    @date_from = params[:date_from]
    @date_to = params[:date_to]
  end

  def scope
    Appointment.where('ends_at between ? and ?', @date_from, @date_to)
  end
end
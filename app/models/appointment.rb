class Appointment < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor

  validates :starts_at, :ends_at, presence: true
  # validates :starts_at, numericality: { greater_than_or_equal_to: DateTime.now.day }
  
  validate :start_date_not_past?

  def start_date_not_past?
    if starts_at.present? && starts_at < DateTime.now
      errors.add :starts_at, "must be after current date"
    end
  end

end

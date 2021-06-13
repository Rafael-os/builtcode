class Appointment < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor

  validates :starts_at, :ends_at, presence: true
  validate :start_date_not_past?, :start_hour_less_than_9?, :start_hour_more_than_18?, :lunch_break?

  private

  def start_date_not_past?
    if starts_at.present? && starts_at < DateTime.now
      errors.add :starts_at, "must be after current date"
    end
  end

  def start_hour_less_than_9?
    if starts_at.present? && starts_at.hour < 9
      errors.add :starts_at, "must be after 9:00"
    end
  end
      
  def start_hour_more_than_18?
    if starts_at.present? && starts_at.hour > 18
      errors.add :starts_at, "must be before 18:00"
    end
  end

  def lunch_break?
    if starts_at.present? && starts_at.hour >= 12 && starts_at.hour < 13
      errors.add :starts_at, "cannot schedule during lunch break"
    end
  end
end

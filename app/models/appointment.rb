class Appointment < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor

  validates :starts_at, :ends_at, presence: true
  validates :starts_at.hour, :inclusion => 9..18
end

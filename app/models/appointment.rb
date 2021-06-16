class Appointment < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor

  validates :starts_at, :ends_at, presence: true
  validate :start_date_not_past?, :start_hour_less_than_9?, :start_hour_more_than_18?, :lunch_break?, :consultation_time, :consultation_period, :time_conflict?

  private

  def start_date_not_past?
    if starts_at.present? && starts_at < DateTime.now
      errors.add :starts_at, "Consulta nao pode ser marcado no passado"
    end
  end

  def start_hour_less_than_9?
    if starts_at.present? && starts_at.hour < 9
      errors.add :starts_at, "Consulta tem que ser depois das 9:00"
    end
  end
      
  def start_hour_more_than_18?
    if starts_at.present? && starts_at.hour >= 18
      errors.add :starts_at, "Consulta tem que ser antes das 18:00"
    end
  end

  def lunch_break?
    if starts_at.present? && starts_at.hour >= 12 && starts_at.hour < 13
      errors.add :starts_at, "Nao pode criar consulta no horario de almoco"
    end
  end

  def consultation_time
    if starts_at.present? && ends_at.present? && ( ends_at - starts_at ) > 1800
      errors.add :ends_at, "Consulta nao pode durar mais de 30 minutos"
    end
  end

  def consultation_period
    if starts_at.present? && ends_at.present? && ( ends_at - starts_at ) < 0
      errors.add :ends_at, "Consulta nao pode terminar antes de comecar"
    end
  end

  def time_conflict?
    if starts_at.present? && ends_at.present?
      if Appointment.where('? < ends_at and ? > starts_at', starts_at, ends_at).any?
        errors.add(:starts_at, 'Ja possui uma consulta neste horario')
      end
    end
  end
end

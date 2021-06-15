class Patient < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_many :doctors, through: :appointments

  validates :name, :cpf, :birth_date, presence: true
  validates :cpf, uniqueness: { message: "CPF ja cadastrado no sistema" }, length: {is: 11}
  validate :birth_date_past?

  private

  def birth_date_past?
    if birth_date.present? && birth_date > Date.today
      errors.add :birth_date, "Data de nascimento tem que ser no passado"
    end
  end
end

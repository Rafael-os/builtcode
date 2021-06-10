class Patient < ApplicationRecord
  has_many :appointments
  has_many :doctors, through: :appointments

  validates :name, :cpf, :birth_date, presence: true
  validates :cpf, uniqueness: true, length: {is: 11}
end

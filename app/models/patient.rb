class Patient < ApplicationRecord
  validates :name, :cpf, :birth_date, presence: true
  validates :cpf, uniqueness: true, length: {is: 11}
end

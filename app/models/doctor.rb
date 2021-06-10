class Doctor < ApplicationRecord
  has_many :appointments
  has_many :patients, through: :appointments

  validates :name, :crm, :crm_uf, presence: true
  validates :crm, uniqueness: { scope: :crm_uf }
end

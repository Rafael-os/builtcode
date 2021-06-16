class Doctor < ApplicationRecord
  default_scope { order(created_at: :asc) }
  
  has_many :appointments
  has_many :patients, through: :appointments

  validates :name, :crm, :crm_uf, presence: true
  validates :crm, uniqueness: { scope: :crm_uf, message: "CRM/UF ja cadastrado no sistema" }
end

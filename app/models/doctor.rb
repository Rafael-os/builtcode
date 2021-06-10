class Doctor < ApplicationRecord
  validates :name, :crm, :crm_uf, presence: true
  validates :crm, uniqueness: { scope: :crm_uf }
end

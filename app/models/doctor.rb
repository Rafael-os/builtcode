class Doctor < ApplicationRecord
  validates :name, :crm, :crm_uf, presence: true
end

class AddUniqueIndexToDoctor < ActiveRecord::Migration[6.1]
  def change
    add_index :doctors, [:crm, :crm_uf], unique: true
  end
end

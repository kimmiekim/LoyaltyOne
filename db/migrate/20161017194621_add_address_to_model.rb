class AddAddressToModel < ActiveRecord::Migration
  def change
    add_column :texts, :address, :string
  end
end

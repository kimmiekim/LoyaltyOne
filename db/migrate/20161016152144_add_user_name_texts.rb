class AddUserNameTexts < ActiveRecord::Migration
  def change
    add_column :texts, :username, :string
  end
end

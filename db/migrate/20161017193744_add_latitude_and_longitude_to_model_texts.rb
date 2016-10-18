class AddLatitudeAndLongitudeToModelTexts < ActiveRecord::Migration
  def change
    add_column :texts, :latitude, :float
    add_column :texts, :longitude, :float
  end
end

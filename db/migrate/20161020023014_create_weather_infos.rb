class CreateWeatherInfos < ActiveRecord::Migration
  def change
    create_table :weather_infos do |t|
      t.string :city
      t.string :data

      t.timestamps null: false
    end
  end
end

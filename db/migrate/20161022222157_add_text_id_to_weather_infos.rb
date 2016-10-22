class AddTextIdToWeatherInfos < ActiveRecord::Migration
  def change
    add_reference :weather_infos, :text, index: true, foreign_key: true
  end
end

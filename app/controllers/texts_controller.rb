require "uri"
require "net/http"

class TextsController < ApplicationController
  # GET /texts
  def index
    # /texts?text=sometext
      render json: { text: params[:text] }
  end

  # GET /texts/new
  def new
    @text = Text.new
  end

  # POST /texts
  def create
    # To make this safer, use text params and define in private function
    # Additionally, you can test if creation was successful and return 500's
    text = Text.create(:text => params[:text], :address => params[:address])
    render json: text
  end

  def create_with_username
    user_input = params[:text]
    username = params[:username]
    address = params[:address]

    text = Text.create(:text => user_input, :username => username, :address => address)

    # Assume that address is a given city input
    weather_data = getWeatherData(address, text)

    # Return list of text's by that user
    texts_by_user = Text.where(username: username).order(created_at: :desc)
    render json: texts_by_user.map { |text|
      t = text.attributes
      t[:temp] = JSON.parse(text.weather_info.data)["main"]["temp"]
      t
    }
  end

  # Doing the weather API call through rails instead of the front end for security
  def getWeatherData(city=nil, text=nil)
    city ||= params[:city]
    json_weather_data = Net::HTTP.get(URI.parse(
      "http://api.openweathermap.org/data/2.5/weather?q=#{city}&units=metric&apiKey=02be9f4871a8fabfb2e1ffbdfd847370"
    ))
    weather_data = JSON.parse(json_weather_data)

    weather_info_hash = {
      :city => weather_data["name"],
      :data => json_weather_data
    }

    if text.blank?
      WeatherInfo.create(weather_info_hash)
    else
      text.build_weather_info(weather_info_hash).save
    end

    #render json: json_weather_data
    return json_weather_data
  end

  private

  def kel_to_cel(kel)
    return kel - 273.15
  end
end

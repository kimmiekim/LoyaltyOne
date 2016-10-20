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

  def getWeatherData(city)
    json_weather_data = Net::HTTP.get(URI.parse("http://api.openweathermap.org/data/2.5/weather?q=#{city}&apiKey=02be9f4871a8fabfb2e1ffbdfd847370"))
    weather_data = JSON.parse(json_weather_data)
    p weather_data

    WeatherInfo.create(
      :city => weather_data[:name],
      :data => json_weather_data
    )
    #render json: json_weather_data
    return json_weather_data
  end

  # POST /texts
  def create
    # To make this safer, use text params and define in private function lke:
    # Text.create(text_params)
    # Additionally, you can test if creation was successful and return 500's
    text = Text.create(:text => params[:text], :address => params[:address])
    render plain: text
  end

  def create_with_username
    user_input = params[:text]
    username = params[:username]
    address = params[:address]

    Text.create(:text => user_input, :username => username, :address => address)

    # Assume that address is a given city input
    weather_data = getWeatherData(address)

    # Return list of text's by that user
    render json: {
      :texts => Text.where(username: username).order(created_at: :desc),
      :weather_data => weather_data
    }
  end

  def show
  end

  def edit
  end

  # PUT /texts
  def update
  end

  def destroy
  end
end

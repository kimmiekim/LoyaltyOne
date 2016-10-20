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

    # Return list of text's by that user
    render json: Text.where(username: username).order(created_at: :desc)
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

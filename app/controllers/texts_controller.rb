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
    Text.create(:text => params[:text])
    render plain: params[:text]
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

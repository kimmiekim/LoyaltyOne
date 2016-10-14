class TextsController < ApplicationController
  def index
    # /texts?text=sometext
      render json: { text: params[:text] }
  end

  def new
  end

  # POST /texts
  def create
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

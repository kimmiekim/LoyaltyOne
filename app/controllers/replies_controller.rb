class RepliesController < ApplicationController
  def create
    user_input = params[:reply_text]
    username = params[:username]
    text_id = params[:text_id]

    Reply.create(reply_text: user_input, username: username, text_id: text_id)
  end
end

class RepliesController < ApplicationController
  def create
    # Get the text to build the reply for
    text_id = params[:text_id]
    text = Text.find_by_id(text_id)

    # build the reply
    user_input = params[:reply_text]
    username = params[:username]
    reply = text.replies.build(reply_text: user_input, username: username)
    reply.save

    # Return full list of json replies related to text
    render json: text.replies
  end
end

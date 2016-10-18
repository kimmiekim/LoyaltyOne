require 'test_helper'

class RepliesControllerTest < ActionController::TestCase
  test "posting to create increases the model count" do
    assert_difference("Reply.count") do
      post :create, { :text_id => Text.last.id, :reply_text => "replies", :username => "bobby the replier" }
    end
  end

  test "posting to create returns the right number of replies to the text" do
    post :create, { :text_id => Text.last.id, :reply_text => "replies", :username => "bobby the replier" }

    assert_equal Text.last.replies.count, JSON.parse(@response.body).length
  end

  test "post content is equal to rendered content" do
    testText = "hello"
    testUsername = "bobby"
    post :create, { :text_id => Text.last.id, :reply_text => testText, :username => testUsername }
    assert_equal testText, Reply.last.reply_text
    assert_equal testUsername, Reply.last.username
  end
end

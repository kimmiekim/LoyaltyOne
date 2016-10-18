require 'test_helper'

class TextsControllerTest < ActionController::TestCase
  test "index should receive string as param and return as json" do
    testString = "testing"
    get :index, { text: testString }
    assert_response :success
    # The response type should be json, implicitly tested with parse
    assert_equal testString, JSON.parse(@response.body)["text"]
  end

  test "post should receive string param and return plain text" do
    testString = "testing"
    post :create, { text: testString }
    assert_response :success
    assert_equal testString, @response.body
  end

  test "post receiving XHR text should return it back" do
    testString = "testing"
    post :create, { text: testString }, xhr: true
    assert_response :success
    assert_equal testString, @response.body
  end

  test "new page should have a text input and button to submit text" do
    get :new
    assert_select 'input'
    assert_select 'button'
  end

  test "posting to create generates new model record" do
    testText = "hello"
    assert_difference('Text.count') do
      post :create, { text: testText }
    end
    assert_equal testText, Text.last.text
  end

  test "posting to create_with_username generates new model record" do
    testText = "hello"
    testUsername = "bobby"

    assert_difference('Text.count') do
      post :create_with_username, { text: testText, username: testUsername }
    end

    assert_equal testText, Text.last.text
    assert_equal testUsername, Text.last.username
  end

  test "posting to create_with_username returns the proper list" do
    #send post request
    testText = "hello"
    testUsername = "bobby"
    post :create_with_username, {text: testText, username: testUsername}

    #parse the post response and check the post response has the right number of texts
    assert_equal Text.where("username = '#{testUsername}'").count, JSON.parse(@response.body).length
  end
end

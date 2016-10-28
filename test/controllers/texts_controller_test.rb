require 'test_helper'

class TextsControllerTest < ActionController::TestCase
  test "index should receive string as param and return as json" do
    testString = "testing"
    get :index, { text: testString }
    assert_response :success
    # The response type should be json, implicitly tested with parse
    assert_equal testString, JSON.parse(@response.body)["text"]
  end

  test "post should receive string param and return correct text info" do
    testString = "testing"
    testAddress = "123 Fake Street"
    post :create, { text: testString, address: testAddress }
    assert_response :success
    assert_equal testString, JSON.parse(@response.body)["text"]
    assert_equal testAddress, JSON(@response.body)["address"]
  end

  test "post receiving XHR text should return it back" do
    testString = "testing"
    post :create, { text: testString }, xhr: true
    assert_response :success
    assert_equal testString, JSON.parse(@response.body)["text"]
  end

  test "new page should have a text input and button to submit text" do
    get :new
    assert_select 'input'
    assert_select 'button'
  end

  test "posting to create generates new model record and has correct info" do
    testText = "hello"
    assert_difference('Text.count') do
      post :create, { text: testText }
    end

    assert_equal testText, Text.last.text
  end

  test "posting to create_with_username generates new model record and has correct content" do
    testText = "hello"
    username = "bobby"
    address = "Toronto"
    assert_difference('Text.count') do
      post :create_with_username, {
        username: username,
        text: testText,
        address: address
      }
    end

    assert_equal testText, Text.last.text
    assert_equal username, Text.last.username
    assert_equal address, Text.last.address
  end

  test "posting to create_with_username gives back full list of texts" do
    username = "bobby"
    post :create_with_username, {
      :text => "test text",
      :username => username,
      :address => "Toronto"
    }

    assert_equal Text.where("username = '#{username}'").count, JSON.parse(@response.body).length
  end

  test "posting to create_with_username creates correct weather data and returns list of relevant data with correct weather data" do
    username = "Bobby"
    post :create_with_username, {
      :text => "test text",
      :username => username,
      :address => "Toronto"
    }

    assert_equal Text.where("username = '#{username}'").count, JSON.parse(@response.body).length

    JSON.parse(@response.body).each do |resp_text|
      assert_equal username, resp_text["username"]
      temp_str = resp_text["temp"]
      # Trick to see if it's an integer
      assert temp_str, temp_str.to_i.to_s
    end
  end
end

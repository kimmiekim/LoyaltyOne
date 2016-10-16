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
end

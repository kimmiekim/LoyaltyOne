require 'test_helper'

class TextsControllerTest < ActionController::TestCase
  test "should get index" do
    testString = "testing"
    get :index, params: { text: testString}
    assert_response :success, "test broken"
  end


  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  # test "should get show" do
  #   get :show
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get :edit
  #   assert_response :success
  # end

  # test "should get update" do
  #   get :update
  #   assert_response :success
  # end
  #
  # test "should get destroy" do
  #   get :destroy
  #   assert_response :success
  # end

end

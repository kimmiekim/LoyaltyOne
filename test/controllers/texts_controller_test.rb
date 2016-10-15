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
end

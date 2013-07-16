require 'test_helper'

class ContentControllerTest < ActionController::TestCase
  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get sources" do
    get :sources
    assert_response :success
  end

end

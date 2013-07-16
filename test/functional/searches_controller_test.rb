require 'test_helper'

class SearchesControllerTest < ActionController::TestCase
  setup do
    @search = searches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:searches)
  end

  test "should create search" do
    assert_difference('Search.count') do
      post :create, search: { user_id: @search.user_id, city: @search.city, min_temp: @search.min_temp, max_temp: @search.max_temp, weather: @search.weather }, format: 'json'
    end

    assert_response(201)
  end

  test "should destroy search" do
    assert_difference('Search.count', -1) do
      delete :destroy, id: @search.id, format: 'json'
    end

    assert_response(204)
  end
end

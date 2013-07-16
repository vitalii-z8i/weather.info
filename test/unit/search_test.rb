require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  test "should not save search with no data" do
    search = Search.new
    assert !search.save

    search.city = "Kyiv"
    assert !search.save

    search.min_temp = 10
    assert !search.save

    search.max_temp = 15
    assert !search.save

    search.weather = 1
    assert !search.save

    search.user_id = 1
    assert search.save
  end

  test "should restrict weather value" do
    search = searches(:two)

    search.weather = 545

    assert !search.save
  end

  test "calculate data" do
    data = [
      {min_temp: 16, max_temp: 22, weather: 1},
      {min_temp:  5, max_temp: 13, weather: 5},
      {min_temp: 28, max_temp: 36, weather: 1}
    ]
    expected = {min_temp: 16.33, max_temp: 23.67, weather: 1}

    search = Search.new

    weather_data = search.calculate_data(data)

    assert_equal expected, weather_data
  end


  test "should not get weather for unknown city" do
    search = Search.new
    unknown_city = "sdfjvjlsdfvsndfvnjsdvnpdvnj"

    search.get_weather(unknown_city)

    assert_nil search.min_temp
    assert_nil search.max_temp
    assert_nil search.weather
  end

  test "should not get weather for empty city" do
    search = Search.new
    search.get_weather('')

    assert_nil search.min_temp
    assert_nil search.max_temp
    assert_nil search.weather
  end
end

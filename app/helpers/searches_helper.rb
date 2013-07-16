module SearchesHelper

  def weather_icon_url(search)
    asset_path("weather/#{search.weather}.png")
  end
end

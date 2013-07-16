class Search < ActiveRecord::Base
  attr_accessible :user_id, :city, :min_temp, :max_temp, :weather

  validates :city, :min_temp, :max_temp, :weather, :user_id, presence: true

  extend Enumerize
  enumerize :weather, :in => { 
    clear:         1, 
    clouds:        2,
    partly_cloudy: 6,
    rain:          3,
    thunderstorm:  4,
    snow:          5,
    unknown:       0 }

  include WeatherParser

  # Sets 'min_temp', 'max_temp' and 'weather' values for a record
  def get_weather(city)

    unless city.nil?

      city = city.to_s.to_slug.normalize(transliterations: :russian).to_s
      
      results = calculate_data([xml_openweather(city), xml_previmeteo(city), xml_worldweatheronline(city)])

      self.min_temp = results[:min_temp]
      self.max_temp = results[:max_temp]

      self.weather = results[:weather]
    end
  end

  # Counts an average weather data from given results
  def calculate_data(weather_data)

    min_temp = []
    max_temp = []
    weather_types = []

    weather_data.each do |data|
      unless data.nil?
        min_temp << data[:min_temp].to_f
        max_temp << data[:max_temp].to_f

        unless data[:weather] == 0
          weather_types << data[:weather]
        end
      end
    end

    # Average min/max temperature
    min_temp = ( min_temp.inject(0.0){ |sum, el| sum + el } / min_temp.size ).round(2)
    max_temp = ( max_temp.inject(0.0){ |sum, el| sum + el } / max_temp.size ).round(2)

    # Most common value in weather types array
    weather = weather_types.group_by { |e| e }.values.max_by(&:size).first if weather_types.any?

    return { min_temp: min_temp, max_temp: max_temp, weather: weather }
  end
end

# Contains weather parsers from different sources 
module WeatherParser
  require 'open-uri'

  # Returns xml responce from http://api.openweathermap.org
  def xml_openweather(city)

    weather_url = URI.escape("http://api.openweathermap.org/data/2.5/weather?q=#{city}&mode=xml&units=metric")

    xml_doc = Nokogiri::XML(open(weather_url))

    return nil if xml_doc.xpath("//current/weather/@number").first.nil?

    weather_id = xml_doc.xpath("//current/weather/@number").first.value.to_i

    weather = case weather_id
              when 200 .. 232
                4
              when 300 .. 321, 500 .. 522
                3
              when 600 .. 621
                5
              when 800
                1
              when 802 .. 804
                2
              when 801
                6
              else
                0
              end


    return {
      max_temp: xml_doc.xpath("current/temperature/@max").first.value,
      min_temp: xml_doc.xpath("current/temperature/@min").first.value,
      weather:  weather }
  end

  # Returns xml responce from http://api.worldweatheronline.com/
  # using registered api key - x7jbzzerewujvnazmk7kkpyc
  def xml_worldweatheronline(city)

    weather_url = URI.escape("http://api.worldweatheronline.com/free/v1/weather.ashx?q=#{city}&format=xml&num_of_days=1&key=x7jbzzerewujvnazmk7kkpyc")

    xml_doc = Nokogiri::XML(open(weather_url))

    return nil unless xml_doc.xpath("//error").text == ''

    weather_type = xml_doc.xpath("//weather/weatherDesc").text

    weather = case weather_type
              when /Sunny/
                1
              when /Partly Cloudy/
                6
              when /rain .* thunder|thunder/
                4
              when /(rain|drizzle|showers)(?!.*thunder)/
                3
              when /Cloudy/
                2
              when /snow|sleet/i
                5
              else
                0
              end

    return { 
      max_temp: xml_doc.xpath("//weather/tempMaxC").text,
      min_temp: xml_doc.xpath("//weather/tempMinC").text,
      weather:  weather }

  end

  # Returns xml from http://api.previmeteo.com 
  # using registered api key - bd04def7aed993fc06d1c52870c701ec
  def xml_previmeteo(city)

    weather_url = URI.escape("http://api.previmeteo.com/bd04def7aed993fc06d1c52870c701ec/ig/api?weather=#{city}&hl=ru")

    begin
      xml_doc = Nokogiri::XML(open(weather_url))

      weather_type = xml_doc.xpath("//forecast_conditions[1]/condition/@data").first.value

      weather = case weather_type
                when 'Sunny'
                  1
                when /\-sunny/
                  6
                when /cloudy/i
                  2
                when /Rain|\-rain/
                  3
                when /hunderstorm(s?)|TStorm|Storm/
                  4
                when /Snow/
                  5
                else
                  0
                end

      return { 
        max_temp: xml_doc.xpath("//forecast_conditions[1]/high/@data").first.value,
        min_temp: xml_doc.xpath("//forecast_conditions[1]/low/@data").first.value,
        weather:  weather }

    rescue
      return nil
    end

  end

end
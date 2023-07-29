module CourseHelper
    require 'faraday'
    require 'json'
    require 'date'

    def denver_fetch_and_filter(future_date)
        future_date = seven_days_from_today if !defined?(future_date)
        url = "https://api.membersports.com/api/v1/golfclubs/groupTeeSheet/1/types/0/%{future_date}" % { future_date: future_date}
        response = Faraday.get(url)
        data = JSON.parse(response.body)
        
        filtered_data = data.each_with_object([]) do |item, result|
            if item['teeTime'] <= 420 
              matching_items = item['items'].select { |i| i['golfCourseNumberOfHoles'] > 9 && i['isBackNine'] == false }
              result.concat(matching_items)
            end
        end

        filtered_data
      end

      def ute_creek_fetch_and_filter(future_date)
        future_date = seven_days_from_today if !defined?(future_date)
        #ute creek wants 2023-08-02
        future_date = convert_date_format(future_date)
        
        url = "https://phx-api-be-east-1b.kenna.io/v2/tee-times?date=%{future_date}&facilityIds=1801" % { future_date: future_date}
        puts "mike #{url}"
        response = Faraday.get url, nil, {'x-be-alias': 'ute-creek-golf-course'}
        data = JSON.parse(response.body)

        data = data[0]["teetimes"]

        data
      end

      def seven_days_from_today
        # Get the current date
        today = Time.now
      
        # Calculate the date seven days from today
        future_date = today + (7 * 24 * 60 * 60)
      
        # Format the date as "mm-dd-yyyy"
        formatted_date = future_date.strftime("%m-%d-%Y")
      
        return formatted_date
      end

      def minutes_since_midnight_to_time(minutes)
        # Calculate the hour and minute values
        hour = minutes / 60
        minute = minutes % 60
      
        # Determine whether it's AM or PM
        period = hour < 12 ? "am" : "pm"
      
        # Adjust hour to 12-hour format if needed
        hour = (hour % 12 == 0) ? 12 : (hour % 12)
      
        # Format the time as "hh:mmam" or "hh:mmpm"
        formatted_time = format("%d:%02d%s", hour, minute, period)
      
        return formatted_time
      end

      def convert_date_format(input_date)
        #give 08-02-2023 and get 2023-08-02
        date = Date.strptime(input_date, '%m-%d-%Y')
        date.strftime('%Y-%m-%d')
      end
end

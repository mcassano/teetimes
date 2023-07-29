module CourseHelper
    require 'faraday'
    require 'json'

    def fetch_and_filter
        url = "https://api.membersports.com/api/v1/golfclubs/groupTeeSheet/1/types/0/%{future_date}" % { future_date: seven_days_from_today }

        response = Faraday.get(url)
        
        # Parse JSON response into a Ruby hash
        data = JSON.parse(response.body)
        
        # Now you can process your data here.
        
        filtered_data = data.each_with_object([]) do |item, result|
            if item['teeTime'] <= 420 
              matching_items = item['items'].select { |i| i['golfCourseNumberOfHoles'] > 9 && i['isBackNine'] == false }
              result.concat(matching_items)
            end
        end

        filtered_data
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
end

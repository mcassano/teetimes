require 'faraday'
require 'json'
require 'date'
require 'active_support/time'

module CourseHelper
    def denver_fetch_and_filter(future_date = seven_days_from_today)
        future_date = convert_date_format(future_date)

        url = "https://api.membersports.com/api/v1/golfclubs/groupTeeSheet/1/types/0/#{future_date}"
        response = Faraday.get(url)
        data = JSON.parse(response.body)

        filtered_data = data.each_with_object([]) do |item, result|
            if item['teeTime'] <= 840
              matching_items = item['items'].select { |i| i['golfCourseNumberOfHoles'] > 9 && i['isBackNine'] == false }
              result.concat(matching_items)
            end
        end

        filtered_data
      end

      def ute_creek_fetch_and_filter(future_date = seven_days_from_today)
        data = fetch_ute_style(1801, future_date, 'ute-creek-golf-course')
        filter_ute_style(data, "Prepaid - Walking")
      end

      def twinpeaks_fetch_and_filter(future_date = seven_days_from_today)
        data = fetch_ute_style(1830, future_date, 'twin-peaks-golf-course')
        filter_ute_style(data, "Walking")
      end

      def meadows_fetch_and_filter(future_date = seven_days_from_today)
        data = fetch_ute_style(1793, future_date, 'foothills-pd')
        filter_ute_style(data, "18 Holes")
      end

      def foothillschamp_fetch_and_filter(future_date = seven_days_from_today)
        data = fetch_ute_style(6826, future_date, 'foothills-pd')
        filter_ute_style(data, "18 Holes")
      end

      def hylandhills_fetch_and_filter(future_date = seven_days_from_today)
        data = fetch_ute_style(9201, future_date, 'hyland-hills-park-recreation-district')
        filter_ute_style(data, "18 Holes")
      end

      def buffalo_fetch_and_filter(future_date = seven_days_from_today)
        data = fetch_ute_style(513, future_date, 'buffalo-run-golf-course')
        filter_ute_style(data, "18 Holes")
      end

      def fetch_ute_style(facility_id, future_date, aliastag)
        url = "https://phx-api-be-east-1b.kenna.io/v2/tee-times?date=#{future_date}&facilityIds=#{facility_id}"

        response = Faraday.get url, nil, {'x-be-alias': aliastag}
        data = JSON.parse(response.body)

        data
      end

      def filter_ute_style(data, standard_rate_description)
        data = data[0]["teetimes"]

        filtered_data = data.each_with_object([]) do |item, result|
          matching_items = item['rates'].select { |i| i['name'] == standard_rate_description}
          if matching_items.length > 0 then
            slots_avail = matching_items[0]["allowedPlayers"].max
            result.concat([{"teetime" => utc_to_mountain(item['teetime']),"slots_avail" => slots_avail}])
          end
        end

        filtered_data
      end

      def seven_days_from_today
        7.days.from_now.strftime("%m-%d-%Y")
      end

      def minutes_since_midnight_to_time(minutes)
        (Date.today.midnight + minutes.minutes).strftime("%l:%M%p")
      end

      def convert_date_format(input_date)
        #give 2023-08-02 and get 08-02-2023
        date = Date.strptime(input_date, '%Y-%m-%d')
        date.strftime('%m-%d-%Y')
      end

      def utc_to_mountain(utc_time_str)
        utc_time = Time.parse(utc_time_str)
        mountain_time = utc_time.in_time_zone('America/Denver')
        mountain_time.strftime('%I:%M%p')
      end
end

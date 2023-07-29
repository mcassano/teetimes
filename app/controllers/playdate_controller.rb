class PlaydateController < ApplicationController
    include CourseHelper
    def show
      @date = params[:date]
      @city_of_denver = denver_fetch_and_filter(params[:date])
      @ute_creek = ute_creek_fetch_and_filter(params[:date])
      @foothills = foothills_fetch_and_filter(params[:date])
    end
  end
  
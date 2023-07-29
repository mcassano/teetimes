class PlaydateController < ApplicationController
    include CourseHelper
    def show
      @date = params[:date]
      @output = denver_fetch_and_filter(params[:date])
    end
  end
  
class CourseController < ApplicationController
  include CourseHelper
  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])

    @output = fetch_and_filter
  end
end

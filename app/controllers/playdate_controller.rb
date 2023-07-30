class PlaydateController < ApplicationController
    include CourseHelper
    def show
      @date = params[:date]
      threads = []
      threads << Thread.new { @city_of_denver = denver_fetch_and_filter(params[:date]) }
      threads << Thread.new { @ute_creek = ute_creek_fetch_and_filter(params[:date]) }
      threads << Thread.new { @twinpeaks = twinpeaks_fetch_and_filter(params[:date]) }
      threads << Thread.new { @meadows = meadows_fetch_and_filter(params[:date]) }
      threads << Thread.new { @foothillschamp = foothillschamp_fetch_and_filter(params[:date]) }
      threads << Thread.new { @hylandhills = hylandhills_fetch_and_filter(params[:date]) }
      threads << Thread.new { @buffalo = buffalo_fetch_and_filter(params[:date]) }
      threads.each(&:join)
    end
  end
  
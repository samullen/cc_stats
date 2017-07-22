class API::PageViewsController < ApplicationController
  def daily_top_urls
    results = PageView.daily_top_urls_since(5.days.ago.to_date)

    render json: results.to_json, status: 200
  end
end

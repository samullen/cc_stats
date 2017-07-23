class API::PageViewsController < ApplicationController
  def daily_top_urls
    results = Rails.cache.fetch("daily_top_urls", expires_in: 1.hour) do
      PageView.daily_top_urls_since(5.days.ago.to_date)
    end

    render json: results.to_json, status: 200
  end

  def daily_top_referrers
    results = Rails.cache.fetch("daily_top_referrers", expires_in: 1.hour) do
      PageView.daily_top_referrers_since(5.days.ago.to_date)
    end

    render json: results.to_json, status: 200
  end
end

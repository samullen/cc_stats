require "test_helper"

class API::PageViewsControllerTest < ActionDispatch::IntegrationTest
  test "GET :: /api/page_views/daily_top_urls" do
    get daily_top_urls_api_page_views_path

    @controller.action_name.must_equal "daily_top_urls"
    @response.body.must_equal "{}"
  end

  test "GET :: /api/page_views/daily_top_referrers" do
    get daily_top_referrers_api_page_views_path

    @controller.action_name.must_equal "daily_top_referrers"
    @response.body.must_equal "{}"
  end
end

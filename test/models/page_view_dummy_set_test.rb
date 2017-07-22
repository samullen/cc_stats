require "test_helper"

describe PageViewDummySet do
  describe "initialization" do
    it "creates a new instance with initial values" do
      set = PageViewDummySet.new
      set.current_id.must_equal 1
      set.ending_id.must_equal 1000
      set.required_urls.must_equal [
        "http://apple.com",
        "https://apple.com",
        "https://www.apple.com",
        "http://developer.apple.com",
        "http://en.wikipedia.org",
        "http://opensource.org"
      ]
      set.required_referrers.must_equal [
        "http://apple.com",
        "https://apple.com",
        "https://www.apple.com",
        "http://developer.apple.com",
        nil
      ]
    end

    it "creates a new instance with specific values given a seed" do
      set = PageViewDummySet.new(1001, 10000)
      set.current_id.must_equal 1001
    end
    it "creates a new instance with specific values given a seed" do
      set = PageViewDummySet.new(1001, 10000)
      set.ending_id.must_equal 11000
    end
  end

  describe "#sql" do
    it "returns an insert statement to create the dummy data" do
      set = PageViewDummySet.new(1, 20)
      set.sql.must_match /INSERT INTO page_views VALUES (\(.+\), ){19}(\(.+\))/
    end
  end

  describe "#records" do
    it "returns records made up of required URLs, referrers, and randoms" do
      set = PageViewDummySet.new(1, 100)
      set.records.must_equal set.required_url_records + set.required_referrer_records + set.random_records
    end
  end

  describe "#required_url_records" do
    it "returns recrods made up of required urls" do
      set = PageViewDummySet.new(1, 50)
      set.required_url_records.size.must_equal 6
      set.required_url_records[0].must_match /1,.+apple\.com/
      set.required_url_records[1].must_match /2,.+apple\.com/
      set.required_url_records[2].must_match /3,.+www\.apple\.com/
      set.required_url_records[3].must_match /4,.+developer\.apple\.com/
      set.required_url_records[4].must_match /5,.+en\.wikipedia\.org/
      set.required_url_records[5].must_match /6,.+opensource\.org/
    end
  end

  describe "#required_url_records" do
    it "returns recrods made up of required urls" do
      set = PageViewDummySet.new(1, 50)
      set.required_referrer_records.size.must_equal 5
      set.required_referrer_records[0].must_match /1,.+?,\s+.+apple\.com/
      set.required_referrer_records[1].must_match /2,.+?,\s+.+apple\.com/
      set.required_referrer_records[2].must_match /3,.+?,\s+.+www\.apple\.com/
      set.required_referrer_records[3].must_match /4,.+?,\s+.+developer\.apple\.com/
      set.required_referrer_records[4].must_match /5,.+?,\s+null,/
    end
  end

  describe "#random_records" do
    it "returns recrods made up of random urls and referrers" do
      set = PageViewDummySet.new(1, 50)
      set.random_records.all? {|rec|
        rec.must_match /\d+, 'https?:.+\.(com|org)', ('https?.+\.(com|org)'|null), '[a-f0-9]{32}', '\d{4}-\d\d-\d\d \d\d:\d\d:\d\d'/
      }
    end
  end
end

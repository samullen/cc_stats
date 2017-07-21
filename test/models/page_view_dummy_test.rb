require "test_helper"

describe PageViewDummy do
  describe "initialization" do
    it "creates a new instance with random initial values" do
      dummy = PageViewDummy.new
      dummy.id.must_be_instance_of Integer
      dummy.url.must_be_instance_of String
      dummy.referrer.must_be_instance_of String
      dummy.created_at.must_be_instance_of Time
    end

    it "creates a new instance with specific values given a seed" do
      dummy = PageViewDummy.new(1)
      dummy.id.must_equal 1
      dummy.url.must_equal "https://apple.com"
      dummy.referrer.must_equal "https://apple.com"
      dummy.created_at.must_be_instance_of Time
    end
  end

  describe "#hash" do
    it "returns an MD5 hash of the attributes" do
      dummy = PageViewDummy.new(1)
      dummy.hash.must_equal Digest::MD5.hexdigest({id: dummy.id, url: dummy.url, referrer: dummy.referrer, created_at: dummy.created_at}.to_s)
    end

    it "doesn't hash attributes with nil values" do
      dummy = PageViewDummy.new(4)
      dummy.hash.must_equal Digest::MD5.hexdigest({id: dummy.id, url: dummy.url, created_at: dummy.created_at}.to_s)
    end
  end
end

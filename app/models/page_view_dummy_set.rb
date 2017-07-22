class PageViewDummySet
  attr_reader :ending_id, :required_urls, :required_referrers
  attr_accessor :current_id

  def initialize(starting_id=1, count=1000)
    @current_id = starting_id
    @ending_id = starting_id + count - 1
    @required_urls = [
      "http://apple.com",
      "https://apple.com",
      "https://www.apple.com",
      "http://developer.apple.com",
      "http://en.wikipedia.org",
      "http://opensource.org"
    ]
    @required_referrers = [
      "http://apple.com",
      "https://apple.com",
      "https://www.apple.com",
      "http://developer.apple.com",
      nil
    ]
  end

  def sql
    "INSERT INTO page_views VALUES #{records.join(", ")}"
  end

  def records
    [required_url_records, required_referrer_records, random_records].flatten
  end

  def required_url_records
    @required_url_records ||= self.required_urls.
      map.with_index(self.current_id) {|url,i|
        self.current_id += 1
        record_for(i, url, random_referrer, random_timestamp.to_s(:db))
      }
  end

  def required_referrer_records
    @required_referrer_records ||= self.required_referrers.
      map.with_index(self.current_id) {|referrer,i|
        self.current_id += 1
        record_for(i, random_url, referrer, random_timestamp.to_s(:db))
      }
  end

  def random_records
    @random_records ||= (self.current_id..self.ending_id).map {|id|
      record_for(id, random_url, random_referrer, random_timestamp.to_s(:db))
    }
  end

  def urls
    @urls ||= required_urls + generic_urls
  end

  def referrers
    @referrers ||= required_referrers + [nil] * 9 + generic_urls
  end

  private

  def record_for(id, url, referrer, timestamp)
    record_hash = {id: id, url: url, referrer: referrer, created_at: timestamp }
    quoted_referrer = referrer ? "'#{referrer}'" : "null"
    "(#{id}, '#{url}', #{quoted_referrer}, '#{hash(record_hash)}', '#{timestamp}')"
  end

  def random_url
    self.urls[rand(self.urls.size)]
  end

  def random_referrer
    self.referrers[rand(self.referrers.size)]
  end

  def random_timestamp
    rand(30).days.ago
  end

  def hash(record_hash)
    Digest::MD5.hexdigest(record_hash.compact.to_s)
  end

  def generic_urls
    @generic_urls ||= [
      "http://sausage.com", "http://blubber.com", "http://pencil.com",
      "http://cloud.com", "http://moon.com", "http://water.com",
      "http://computer.com", "http://school.com", "http://network.com",
      "http://hammer.com", "http://walking.com", "http://violently.com",
      "http://mediocre.com", "http://literature.com", "http://chair.com",
      "http://two.com", "http://window.com", "http://cords.com",
      "http://musical.com", "http://zebra.com", "http://xylophone.com",
      "http://penguin.com", "http://home.com", "http://dog.com",
      "http://final.com", "http://ink.com", "http://teacher.com",
      "http://fun.com", "http://website.com", "http://banana.com",
      "http://uncle.com", "http://softly.com", "http://mega.com",
      "http://ten.com", "http://awesome.com", "http://attatch.com",
      "http://blue.com", "http://internet.com", "http://bottle.com",
      "http://tight.com", "http://zone.com", "http://tomato.com",
      "http://prison.com", "http://hydro.com", "http://cleaning.com",
      "http://telivision.com", "http://send.com", "http://frog.com",
      "http://cup.com", "http://book.com", "http://zooming.com",
      "http://falling.com", "http://evily.com", "http://gamer.com",
      "http://lid.com", "http://juice.com", "http://moniter.com",
      "http://captain.com", "http://bonding.com", "http://loudly.com",
      "http://thudding.com", "http://guitar.com", "http://shaving.com",
      "http://hair.com", "http://soccer.com", "http://water.com",
      "http://racket.com", "http://table.com", "http://late.com",
      "http://media.com", "http://desktop.com", "http://flipper.com",
      "http://club.com", "http://flying.com", "http://smooth.com",
      "http://monster.com", "http://purple.com", "http://guardian.com",
      "http://bold.com", "http://hyperlink.com", "http://presentation.com",
      "http://world.com", "http://national.com", "http://comment.com",
      "http://element.com", "http://magic.com", "http://lion.com",
      "http://sand.com", "http://crust.com", "http://toast.com",
      "http://jam.com", "http://hunter.com", "http://forest.com",
      "http://foraging.com", "http://silently.com", "http://tawesomated.com",
      "http://joshing.com", "http://pong.com"
    ]
  end
end

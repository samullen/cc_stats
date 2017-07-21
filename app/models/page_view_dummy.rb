class PageViewDummy
  attr_reader :id, :url, :referrer, :created_at

  def initialize(id=nil)
    @id = id || rand(150)
    @url = urls[@id % urls.size]
    @referrer = referrers[@id % referrers.size]
    @created_at = rand(30).days.ago.to_s(:db)
  end

  def hash
    @hash ||= Digest::MD5.hexdigest({
      id: self.id, 
      url: self.url, 
      referrer: self.referrer, 
      created_at: self.created_at
    }.compact.to_s)
  end

  def to_s
    "(#{self.id}, '#{self.url}', '#{self.referrer}', '#{self.hash}', '#{self.created_at}')"
  end

  private

  def urls
    @urls ||= [
      "http://apple.com",
      "https://apple.com",
      "https://www.apple.com",
      "http://developer.apple.com",
      "http://en.wikipedia.org",
      "http://opensource.org"
    ] + generic_urls
  end

  def referrers
    @referrers ||= [
      "http://apple.com",
      "https://apple.com",
      "https://www.apple.com",
      "http://developer.apple.com",
      nil
    ] + generic_urls
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

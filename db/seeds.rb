PageView.exclude(id: nil).delete
1.step(by: 1000, to: 1_000_000).each do |id|
  PageView.db.run(PageViewDummySet.new(id).sql)
end

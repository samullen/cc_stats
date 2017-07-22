class PageView < Sequel::Model
  def self.daily_top_urls_since(date)
    sql = <<-SQL
      SELECT created_at::date, url, count(url) as visits
        FROM page_views 
       WHERE created_at > '#{date}'
       GROUP BY created_at::date, url
       ORDER BY created_at desc
    SQL
    self.db[sql].all.group_by {|pv| pv[:created_at].to_s(:db)}
  end
end

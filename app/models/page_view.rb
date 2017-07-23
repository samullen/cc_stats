class PageView < Sequel::Model
  def self.daily_top_urls_since(date)
    sql = <<-SQL
      SELECT created_at::date, url, count(url) as visits
        FROM page_views 
       WHERE created_at > ?
       GROUP BY created_at::date, url
       ORDER BY created_at desc
    SQL
    self.db[sql, date].all.group_by {|pv| pv[:created_at].to_s(:db)}
  end

  def self.daily_top_referrers_since(date)
    sdate = date
    results = {}

    sql = <<-SQL
      SELECT series.series_date, urls.url, urls.visits, urls.rank, 
             referrers.referrer, referrers.referrer_count, referrers.rank
        FROM (SELECT generate_series(:sdate::date, :edate::date, '1 day')::date as series_date) as series
             INNER JOIN (
               SELECT url, created_at::date, count(page_views.url) as visits, 
                      rank() OVER (partition by created_at::date ORDER BY count(url) desc)
                 FROM page_views
                WHERE page_views.created_at >= :sdate
                GROUP BY url, created_at::date
             ) AS urls
               ON series.series_date = urls.created_at
              AND urls.rank <= 10
             INNER JOIN (
               SELECT url, referrer, created_at::date, 
                      count(referrer) as referrer_count, 
                      rank() OVER (partition by url, created_at::date ORDER BY count(referrer) desc)
                 FROM page_views
                WHERE page_views.created_at >= :sdate
                  AND referrer IS NOT NULL
                GROUP BY url, referrer, created_at::date
                ORDER BY url, created_at::date desc, rank
             ) AS referrers
               ON urls.url = referrers.url
              AND urls.created_at::date = referrers.created_at::date
              AND referrers.rank <= 5
       ORDER BY series.series_date desc, urls.rank, url, referrers.rank
    SQL
    self.db[sql, {sdate: sdate, edate: Date.today}].all.each do |row|
      date = row[:series_date].to_s(:db)
      url = row[:url]

      results[date] ||= {}
      results[date][url] ||= {visits: row[:visits], referrers: []}
      results[date][url][:referrers] << {
        url: row[:referrer],
        visits: row[:referrer_count]
      }
    end

    results
  end
end

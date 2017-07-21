Sequel.migration do
  change do
    add_index :page_views, :url
    add_index :page_views, :referrer
    add_index :page_views, :created_at
  end
end

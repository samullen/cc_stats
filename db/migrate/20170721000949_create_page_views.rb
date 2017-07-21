Sequel.migration do
  change do

    create_table :page_views do
      primary_key :id
      column :url, String, null: false, limit: 2056
      column :referrer, String, limit: 2056
      column :hash, String, limit: 64
      column :created_at, DateTime
    end

  end
end

Sequel.migration do
  change do
    create_table(:page_views) do
      primary_key :id
      column :url, "text", :null=>false
      column :referrer, "text"
      column :hash, "text"
      column :created_at, "timestamp without time zone"
      
      index [:created_at]
      index [:referrer]
      index [:url]
    end
    
    create_table(:schema_migrations) do
      column :filename, "text", :null=>false
      
      primary_key [:filename]
    end
  end
end
              Sequel.migration do
                change do
                  self << "SET search_path TO \"$user\", public"
                  self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20170721000949_create_page_views.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20170721003055_add_indexes_to_page_views.rb')"
                end
              end

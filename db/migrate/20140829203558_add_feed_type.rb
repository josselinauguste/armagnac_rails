class AddFeedType < ActiveRecord::Migration
  def change
    add_column :feeds, :format, :string, null: false, default: 'rss'
    rename_column :feeds, :url, :source
  end
end

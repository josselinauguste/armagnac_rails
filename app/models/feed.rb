require 'feedzirra'

class Feed < ActiveRecord::Base

  attr_reader :title
  attr_reader :new_entries

  def fetch
    feed = Feedzirra::Feed.fetch_and_parse(url)
    @title = feed.title
    @new_entries = feed.entries
    if fetched_at
      @new_entries = @new_entries.select { |e| e.published > fetched_at }
    end
  end
end

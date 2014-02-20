require 'feedzirra'

class Feed < ActiveRecord::Base

  attr_reader :title
  attr_reader :entries

  def fetch
    feed = Feedzirra::Feed.fetch_and_parse(url)
    @title = feed.title
    @entries = feed.entries
    if fetched_at
      @entries = @entries.select { |e| e.published > fetched_at }
    end
  end
end

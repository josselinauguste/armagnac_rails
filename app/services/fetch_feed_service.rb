class FetchFeedService
  def fetch_new(feed)
    fetched_feed = Feedjira::Feed.fetch_and_parse(feed.url)
    entries = fetched_feed.entries
    if feed.fetched_at
      entries = entries.take_while { |e| e.published > feed.fetched_at }
    end
    feed.touch(:fetched_at)
    return fetched_feed.title, entries
  end
end

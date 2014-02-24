class SendDigestsService
  def send(feed_id)
    feed = Feed.find(feed_id)
    feed.fetch
    unless feed.new_entries.empty?
      DigestMailer.digest_email(feed.title, feed.new_entries, 'jauguste@iblop.net').deliver
    end
    feed.touch(:fetched_at)
  end
end

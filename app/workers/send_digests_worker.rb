class SendDigestsWorker
  include Sidekiq::Worker

  def perform(feed_id)
    feed = Feed.find(feed_id)
    feed.fetch
    DigestMailer.digest_email(feed.title, feed.entries, 'jauguste@iblop.net').deliver
    feed.touch(:fetched_at)
  end

  def self.send_digests
    Feed.pluck(:id).each do |feed_id|
      perform_async feed_id
    end
  end
end

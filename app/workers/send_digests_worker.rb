class SendDigestsWorker
  def self.send_digests
    service = FetchFeedService.new
    Feed.all.each do |feed|
      title, new_entries = service.fetch_new(feed)
      unless new_entries.empty?
        DigestMailer.feed_digest(title, new_entries, 'jauguste@iblop.net').deliver
      end
    end
  end
end

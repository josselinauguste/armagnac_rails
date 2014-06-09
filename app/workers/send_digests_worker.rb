class SendDigestsWorker
  def self.send_digests
    service = SendDigestsService.new
    Feed.pluck(:id).each do |feed_id|
      service.send(feed_id)
    end
  end
end

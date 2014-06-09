class SendDigestsWorker
  def perform(feed_id)
    SendDigestsService.new.send(feed_id)
  end

  def self.send_digests
    worker = self.new
    Feed.pluck(:id).each do |feed_id|
      worker.perform feed_id
    end
  end
end

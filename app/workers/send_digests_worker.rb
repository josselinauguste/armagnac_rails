class SendDigestsWorker
  include Sidekiq::Worker

  def perform(feed_id)
    SendDigestsService.new.send(feed_id)
  end

  def self.send_digests
    Feed.pluck(:id).each do |feed_id|
      perform_async feed_id
    end
  end
end

class DigestsController < ApplicationController
  def process_feeds
    service = SendDigestsService.new
    Feed.pluck(:id).each do |feed_id|
      service.send(feed_id)
    end

    head :ok
  end
end

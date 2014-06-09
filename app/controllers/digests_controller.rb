class DigestsController < ApplicationController
  def run
    SendDigestsWorker.send_digests

    head :ok
  end
end

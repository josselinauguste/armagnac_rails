class DigestsController < ApplicationController
  def run
    job = Job.last
    if job
      if job.updated_at.to_date < Date.today && Date.today.wday == 5 && DateTime.now > DateTime.now.change({:hour => 20})
        SendDigestsWorker.send_digests
        job.touch
      end
      head :ok
    else
      head :not_found
    end
  end
end

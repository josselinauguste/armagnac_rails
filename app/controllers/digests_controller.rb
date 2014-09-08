class DigestsController < ApplicationController
  def watch
    job = Job.last
    if job
      if params['force'].present? || job.ready?
        SendDigestsWorker.send_digests
        job.touch
      end
      head :ok
    else
      head :not_found
    end
  end
end

class Job < ActiveRecord::Base
  def ready?
    updated_at.to_date < Date.today && Date.today.wday == 5 && DateTime.now > DateTime.now.change({:hour => 12})
  end
end

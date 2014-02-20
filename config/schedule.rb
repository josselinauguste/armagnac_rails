every :friday, :at => '20pm' do
  runner "SendDigestsWorker.send_digests"
end

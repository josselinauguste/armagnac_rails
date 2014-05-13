class DigestMailer < ActionMailer::Base
  default from: "bouilleurdecru@armagnac.io"

  def feed_digest(title, entries, to)
    @title = title
    @entries = entries
    mail(to: to, subject: "Your digest about '#{title}'")
  end
end

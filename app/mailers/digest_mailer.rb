class DigestMailer < ActionMailer::Base
  default from: "bouilleurdecru@armagnac.io"

  def digest_email(title, entries, to)
    @title = title
    @entries = entries
    mail(to: to, subject: "Your weekly digest for the feed '#{title}'")
  end
end

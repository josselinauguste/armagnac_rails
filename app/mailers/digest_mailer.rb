class DigestMailer < ActionMailer::Base
	add_template_helper(TruncateHtmlHelper)

  default from: "bouilleurdecru@armagnac.io"

  def feed_digest(title, entries, to)
    @title = title
    @entries = entries
    mail(to: to, subject: "'#{title}' digested")
  end
end

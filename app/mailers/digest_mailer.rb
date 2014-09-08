class DigestMailer < ActionMailer::Base
  add_template_helper(TruncateHtmlHelper)
	add_template_helper(DigestsHelper)

  default from: "bouilleurdecru@armagnac.io"

  def feed_digest(title, entries, to)
    @title = title
    @entries = entries
    mail(to: to, subject: "'#{title}' digested")
  end
end

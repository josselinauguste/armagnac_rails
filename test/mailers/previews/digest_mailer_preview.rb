# Preview all emails at http://localhost:3000/rails/mailers/digest_mailer
class DigestMailerPreview < ActionMailer::Preview
	def feed_digest
		feed = Feed.first
		DigestMailer.feed_digest(feed.title, feed.new_entries, 'jauguste@iblop.net')
	end
end

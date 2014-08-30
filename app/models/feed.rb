require 'feedzirra'

class Feed < ActiveRecord::Base

  validates_presence_of :source

  def url
    case self.format
    when 'facebook' then facebook_url
    else source
    end
  end

  private
  def facebook_url
    response = HTTParty.get("https://graph.facebook.com/#{source}")
    if response.code == 200
      page = JSON.parse(response.body)
      "https://www.facebook.com/feeds/page.php?id=#{page['id']}&format=rss20"
    end
  end
  
end

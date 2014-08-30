require 'test_helper'

class FeedTest < ActiveSupport::TestCase
  test 'get rss url' do
    feed = feeds(:rss)
    
    assert_equal feed.source, feed.url
  end

  test 'get facebook url' do
    stub_request(:get, /https:\/\/graph.facebook.com\/roda/).to_return(body: '
      {
         "id": "666",
         "about": "Roda de Choro de Bordeaux",
         "can_post": false,
         "category": "Musician/band",
         "checkins": 0,
         "cover": {
            "cover_id": 278838588954438,
            "offset_x": 0,
            "offset_y": 53,
            "source": "https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xpa1/v/t1.0-9/10342797_278838588954438_5182868129700988923_n.jpg?oh=26e73f163b6ceada46a6d89809418126&oe=5469E981&__gda__=1415479353_b420b127510da9ce4c7d47cb93e75260"
         },
         "current_location": "Bordeaux",
         "description": "Roda de Choro de Bordeaux est un rencontre musical organis\u00e9e par Veronica Baird-Smith",
         "general_manager": "Veronica Baird-Smith",
         "genre": "choro - musique instrumental du Br\u00e9sil",
         "has_added_app": false,
         "hometown": "Bordeaux",
         "is_community_page": false,
         "is_published": true,
         "likes": 125,
         "link": "https://www.facebook.com/roda",
         "name": "Roda de Choro de Bordeaux",
         "parking": {
            "lot": 0,
            "street": 0,
            "valet": 0
         },
         "talking_about_count": 15,
         "username": "rodadechorodebordeaux",
         "were_here_count": 0
      }')
    feed = Feed.new({source: 'roda', format: 'facebook'})

    assert_equal 'https://www.facebook.com/feeds/page.php?id=666&format=rss20', feed.url
  end
end

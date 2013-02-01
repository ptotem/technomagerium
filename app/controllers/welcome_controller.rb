class WelcomeController < ApplicationController
  def index
  end

  def library
    @puzzles=Puzzle.all
    @tomes=Tome.all
    gon.help_on = ((current_user.sign_in_count == 1) ? false : true)

    @graph = Koala::Facebook::API.new("AAAB7MQaJdbMBAAwYykwBEbOh4Lsq1PWFlt2TQkoHidhAvtLlxca1gJCbOp8pkpNx6PvhDr5EHuJjNCwmt90UQJnKvL9ZCGIZB9kWlJCwZDZD")

    #@profile = @graph.get_object("me")
    #@friends = @graph.get_connections("me", "friends")
    #@graph.put_connections("me", "feed", :message => "Testing a facebook app. Please ignore.")

    # three-part queries are easy too!
    #@graph.get_connections("me", "mutualfriends/#{friend_id}")

    # you can even use the new Timeline API
    # see https://developers.facebook.com/docs/beta/opengraph/tutorial/
    #@graph.put_connections("me", "namespace:action", :object => object_url)

  end
end

class WelcomeController < ApplicationController
  def index
  end

  def library
    @puzzles=Puzzle.all
    if current_user.user_state.nil?
      UserState.create!(user_id: current_user.id, tome_id: Tome.first.id, bookmark: 0)
    end
    @last_tome=current_user.user_state.tome
    if current_user.admin
      @tomes=Tome.all
    else
      @tomes=Tome.where("chapter=?", params[:chapter]).all.select{|t| (t.sequence<((@last_tome.sequence) +1))}.map{|t| t}
    end

    gon.help_on = ((current_user.sign_in_count == 1 and @last_tome.sequence==1) ? true : false)

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

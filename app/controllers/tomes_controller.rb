class TomesController < ApplicationController
  def show
    @tome=Tome.find(params[:id])
    UserState.find_or_create_by_tome_id_and_user_id(Tome.find_by_sequence(@tome.sequence-1).id,current_user.id)
    end
  def knowledge
    @tome=Tome.find(params[:id])
    @next_tome=Tome.find_by_sequence(@tome.sequence+1)
    @story_pages=current_user.story_pages.all
  end
end

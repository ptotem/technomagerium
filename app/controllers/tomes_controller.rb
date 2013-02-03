class TomesController < ApplicationController
  def show
    @tome=Tome.find(params[:id])
    unless current_user.user_state.tome==@tome
      current_user.user_state.tome_id=@tome.id
      current_user.user_state.save
    end
  end

  def knowledge
    @tome=Tome.find(params[:id])
    @next_tome=Tome.find_by_sequence(@tome.sequence+1)
    @story_pages=current_user.story_pages.all
    gon.jump_to_end= (params[:end].blank? ? false : true)
  end
end

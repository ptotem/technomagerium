class TomesController < ApplicationController
  def show
    @tome=Tome.find(params[:id])
    unless current_user.user_state.tome==@tome or current_user.user_state.tome.sequence> @tome.sequence
      current_user.user_state.tome_id=@tome.id
    end
    current_user.user_state.bookmark=StoryPage.last.num
    current_user.user_state.save
  end

  def knowledge
    @tome=Tome.find(params[:id])
    @next_tome=(Tome.find_by_sequence(current_user.story_pages.where(chapter_break: true).count).blank? ? @tome : Tome.find_by_sequence(current_user.story_pages.where(chapter_break: true).count))
    @story_pages=current_user.story_pages.all
    gon.bookmark = current_user.user_state.bookmark
  end

  def creatopedia
    @tome=Tome.find(params[:id])
    @entries=current_user.games.where('solved=?', true).map { |g| g.puzzle.encyclopedia_entry }
    #@entries=Puzzle.all.map { |p| p.encyclopedia_entry }
    @pages=[]
    counter=-1
    @entries.each_with_index do |e, index|
      if index%3==0
        counter+=1
        @pages[counter]=[]
      end
      @pages[counter]<< e
    end
  end

  def admin
    @tome=Tome.find(params[:id])
    @next_tome=(Tome.find_by_sequence(@tome.sequence+1).blank? ? @tome :Tome.find_by_sequence(@tome.sequence+1))
    @story_pages=current_user.story_pages.all
    gon.bookmark = current_user.user_state.bookmark
  end
end

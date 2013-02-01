class TomesController < ApplicationController
  def show
    @tome=Tome.find(params[:id])
    end
  def knowledge
    @tome=Tome.find(params[:id])
    @story_pages=current_user.story_pages.all
  end
end

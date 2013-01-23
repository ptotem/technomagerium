class TomesController < ApplicationController
  def show
    @tome=Tome.find(params[:id])
  end
end

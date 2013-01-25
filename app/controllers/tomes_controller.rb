class TomesController < ApplicationController
  def show
    @tome=Tome.find(params[:id])
    end
  def tutorial
  end
end

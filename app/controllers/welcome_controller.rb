class WelcomeController < ApplicationController
  def index
  end

  def library
    @puzzles=Puzzle.all
  end
end

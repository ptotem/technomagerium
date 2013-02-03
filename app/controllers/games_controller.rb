class GamesController < ApplicationController

  def play

    if Game.find_by_puzzle_id_and_user_id(params[:id], current_user.id).blank?
      @game=Game.create!(puzzle_id: params[:id], user_id: current_user.id, solved: false)
    else
      @game=Game.find_by_puzzle_id_and_user_id(params[:id], current_user.id)
    end

    @cluestat=[@game.lore, @game.counter, @game.revelation]

    @theme=@game.puzzle.tome.theme
    gon.game_id=@game.id
    gon.theme=@theme
    gon.costs_in = @game.puzzle.manacost? ? 'magic' :'techno'
    gon.elements=@game.puzzle.tome.elements.split(",")
    gon.count=@game.puzzle.tome.elements.split(",").count

    @gamechecker=""
    @game.puzzle.tome.elements.split(",").count.times do
      @gamechecker<<"0"
    end
    gon.checker=@gamechecker


    @clue_cost = t(:"clue_cost_schema.#{@game.puzzle.clue_cost_schema}").split("|")
    @clue_cost.each_with_index do |c, index|
      if c=="0"
        case index
          when 0
            @game.lore=true
          when 1
            @game.counter=true
          when 2
            @game.revelation=true
        end
      end
      @game.save
    end

    if @game.solved?
      @lock_status=["", "", ""]
      gon.clue_costs=[0, 0, 0]
    else
      @lock_status=@clue_cost.each_with_index.map { |c, index|
        if (c=="x") then
          "_disabled"
        elsif (c=="0" or @cluestat[index]) then
          ""
        else
          "_locked"
        end }
      gon.clue_costs=@clue_cost.map { |c|
        if (c=="x") then
          0
        elsif (c=="0") then
          0
        else
          ((c.to_i)*(@game.puzzle.mana_reward+@game.puzzle.power_reward)/100)
        end }
    end
    gon.clue_speak=t(:cluespeak).keys.map { |c| t(:"cluespeak.#{c}") }
  end


  def take_clue
    @game=Game.find(params[:id])
    @theme=params[:theme]
    @clue=params[:name]
    @clue_cost = t(:"clue_cost_schema.#{@game.puzzle.clue_cost_schema}").split("|")
    @clue_costs=@clue_cost.map { |c|
      if (c=="x") then
        0
      elsif (c=="0") then
        0
      else
        ((c.to_i)*(@game.puzzle.mana_reward+@game.puzzle.power_reward)/100)
      end }
    case @clue
      when "lore"
        @index=1
        @cost=@clue_costs[0]
        if (@game.puzzle.manacost and @cost <= @game.user.mana) or (!@game.puzzle.manacost and @cost <= @game.user.power)
          @game.lore=true
          @game.puzzle.manacost ? @game.user.mana-=@cost : @game.user.power-=@cost
          @game.save
          @game.user.save
          @status=@cost
          @response=@game.puzzle.lore
        else
          @status="You do not have enough resources to buy this"
          @theme="x"
        end
      when "count"
        @index=2
        @cost=@clue_costs[1]
        if (@game.puzzle.manacost and @cost <= @game.user.mana) or (!@game.puzzle.manacost and @cost <= @game.user.power)
          @game.counter=true
          @theme=="magic" ? @game.user.mana-=@cost : @game.user.power-=@cost
          @game.save
          @game.user.save
          @status=@cost
          @response=@game.puzzle.combo.scan("1").count
        else
          @status="You do not have enough resources to buy this"
          @theme="x"
        end
      when "chance"
        @index=3
        @cost=@clue_costs[2]
        if (@game.puzzle.manacost and @cost <= @game.user.mana) or (!@game.puzzle.manacost and @cost <= @game.user.power)
          @game.revelation=true
          @theme=="magic" ? @game.user.mana-=@cost : @game.user.power-=@cost
          @status=@cost
          @bitmask=@game.puzzle.combo.split(//).map { |c| c.to_i }
          @response=@game.puzzle.tome.elements.split(",").select.with_index { |e, i| @bitmask[i] == 1 }.sample(Random.rand(2)+1).join(",")
          @game.revealed=@response
          @game.save
          @game.user.save
        else
          @status="You do not have enough resources to buy this"
          @theme="x"
        end
    end

    render :text => "#{@theme}||#{@status}||#{@clue}||#{@response}||#{@index}"
  end

  def clue_status
    @game=Game.find(params[:id])
    case params[:name]
      when "lore"
        render :text => "#{@game.lore}||#{@game.puzzle.lore if @game.lore}"
      when "count"
        render :text => "#{@game.counter}||#{@game.puzzle.combo.scan("1").count if @game.counter}_#{@game.puzzle.tome.theme if @game.counter}"
      when "chance"
        render :text => "#{@game.revelation}||#{@game.revealed if @game.revelation}"
      when "explanation"
        @tome_completion = @game.puzzle.tome.puzzles.count - current_user.games.where('solved=?', true).map { |g| g.puzzle }.select { |p| p.tome_id==@game.puzzle.tome.id }.count
        if @tome_completion==0
          @redirection="/library/#{@game.puzzle.tome.chapter+1}"
        else
          @incomplete_puzzles=(@game.puzzle.tome.puzzles - current_user.games.where('solved=?', true).map { |g| g.puzzle }.select { |p| p.tome_id==@game.puzzle.tome.id }.map { |p| p }).sort
          if (@game.puzzle.sequence+1)>@incomplete_puzzles.map{|p| p.sequence}.max
            @redirection="/play/#{@incomplete_puzzles.first.id}"
          else
            @target=@game.puzzle.sequence
            greater_than = []
            @incomplete_puzzles.map { |p| p.sequence }.each do |elmt|
              if elmt > @target
                greater_than << elmt
              end
            end
            @redirection="/play/#{Puzzle.find_by_sequence(greater_than.min).id}"
          end
        end

        render :text => "#{@game.solved}||#{@game.puzzle.explanation if @game.solved}||#{@redirection if @game.solved}"
    end
  end

  def checker
    @game=Game.find(params[:id])
    @user=@game.user
    @bitmask=params[:bitmask]
    if @bitmask==@game.puzzle.combo
      @game.lore=true
      @game.solved=true
      if @game.save
        @tome_completion = @game.puzzle.tome.puzzles.count - @user.games.where('solved=?', true).map { |g| g.puzzle }.select { |p| p.tome_id==@game.puzzle.tome.id }.count
        if @tome_completion == 0
          UserState.create!(user_id: @user.id, tome_id: @game.puzzle.tome.id)
          @last_page=StoryPage.find_all_by_user_id(@user.id).last.num rescue 0
          @game.puzzle.tome.ending.split("||").each_with_index do |e, index|
            StoryPage.create!(user_id: @user.id, num: (@last_page+index+1), progress: e)
          end
          if Tome.find_by_sequence_and_chapter(@game.puzzle.tome.sequence+1, @game.puzzle.tome.chapter).blank?
            StoryPage.create!(user_id: @user.id, num: (StoryPage.find_all_by_user_id(@user.id).last.num+1), progress: "<div class='chapter_end'><a href='/library/#{(@game.puzzle.tome.chapter+1)}'>Next Chapter</a></div>")
          end
          StoryPage.create!(user_id: @user.id, num: (StoryPage.find_all_by_user_id(@user.id).last.num+1 rescue 1), progress: (@game.puzzle.tome.sequence+1))
          @last_page=StoryPage.find_all_by_user_id(@user.id).last.num
          @next_tome=Tome.find_by_sequence_and_chapter(@game.puzzle.tome.sequence+1, @game.puzzle.tome.chapter)
          @game.puzzle.tome.beginning.split("||").each_with_index do |e, index|
            StoryPage.create!(user_id: @user.id, num: (@last_page+index+1), progress: e)
          end
        end
      end
      @user.mana+=@game.puzzle.mana_reward
      @user.power+=@game.puzzle.power_reward
      @user.save

      render :text => "y||#{@user.mana}||#{@user.power}"
    else
      render :text => "n"
    end
  end

  def game_status
    @game=Game.find(params[:id])
    @response=@game.puzzle.combo.split(//).each_with_index.map { |c, index| (c=='1') ? index+1 : 0 }.select { |e| e!=0 }.join(",")
    render :text => "#{@game.solved}||#{@response}"

  end


  # GET /games
  # GET /games.json
  def index
    @games = Game.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/new
  # GET /games/new.json
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(params[:game])

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end
end

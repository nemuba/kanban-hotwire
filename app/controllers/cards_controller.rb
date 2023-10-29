# frozen_string_literal: true

class CardsController < ApplicationController
  before_action :set_workspace
  before_action :set_board
  before_action :set_card, only: %i[show edit update destroy]

  # GET /cards
  def index
    @cards = @board.cards
  end

  # GET /cards/1
  def show; end

  # GET /cards/new
  def new
    @card = @board.cards.build
  end

  # GET /cards/1/edit
  def edit; end

  # POST /cards
  def create
    @card = Card.new(card_params)

    respond_to do |format|
      if @card.save
        format.turbo_stream { render 'cards/turbo_stream/create' }
        format.html { redirect_to workspace_board_path(@workspace, @board), notice: 'Card was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /cards/1
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.turbo_stream { render 'cards/turbo_stream/update' }
        format.html { redirect_to workspace_board_path(@workspace, @board), notice: 'Card was successfully updated.' }
      else
        render :edit
      end
    end
  end

  # DELETE /cards/1
  def destroy
    @card.destroy
    @cards_count = @board.cards.count

    respond_to do |format|
      format.turbo_stream { render 'cards/turbo_stream/destroy' }
      format.html { redirect_to workspace_board_path(@workspace, @board), notice: 'Card was successfully destroyed.' }
    end
  end

  def move
    @workspace = Workspace.find(params[:workspace_id])
    @board = @workspace.boards.find(params[:board_id])
    @card = Card.find(params[:card_id])

    respond_to do |format|
      if @card.update(board_id: @board.id)
        format.turbo_stream { render 'cards/turbo_stream/move' }
        format.html { redirect_to workspace_board_path(@workspace, @board), notice: 'Card was successfully moved.' }
      else
        format.html { redirect_to workspace_board_path(@workspace, @board), notice: 'Card was not moved.' }
      end
    end
  end

  private

  def set_workspace
    @workspace = Workspace.find(params[:workspace_id])
  end

  def set_board
    @board = @workspace.boards.find(params[:board_id])
  end

  def set_card
    @card = @board.cards.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:title, :description, :position, :board_id)
  end
end

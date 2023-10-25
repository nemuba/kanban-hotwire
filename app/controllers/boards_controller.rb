# frozen_string_literal: true

class BoardsController < ApplicationController
  before_action :set_workspace
  before_action :set_board, only: %i[show edit update destroy]

  # GET /boards
  def index
    @boards = @workspace.boards
  end

  # GET /boards/1
  def show; end

  # GET /boards/new
  def new
    @board = @workspace.boards.build
  end

  # GET /boards/1/edit
  def edit; end

  # POST /boards
  def create
    @board = Board.new(board_params)

    respond_to do |format|
      if @board.save
        format.turbo_stream { render 'boards/turbo_stream/create' }
        format.html { redirect_to workspace_path(@workspace), notice: 'Board was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /boards/1
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.turbo_stream { render 'boards/turbo_stream/update' }
        format.html { redirect_to workspace_path(@workspace), notice: 'Board was successfully updated.' }
      else
        render :edit
      end
    end
  end

  # DELETE /boards/1
  def destroy
    @board.destroy

    respond_to do |format|
      format.turbo_stream { render 'boards/turbo_stream/destroy' }
      format.html { redirect_to workspace_path(@workspace), notice: 'Board was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_board
    @board = @workspace.boards.find(params[:id])
  end

  def set_workspace
    @workspace = Workspace.find(params[:workspace_id])
  end

  # Only allow a trusted parameter "white list" through.
  def board_params
    params.require(:board).permit(:title, :workspace_id)
  end
end

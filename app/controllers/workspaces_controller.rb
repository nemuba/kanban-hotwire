# frozen_string_literal: true

class WorkspacesController < ApplicationController
  before_action :set_workspace, only: %i[show edit update destroy]

  # GET /workspaces or /workspaces.json
  def index
    @workspaces = Workspace.recent
  end

  # GET /workspaces/1 or /workspaces/1.json
  def show; end

  # GET /workspaces/new
  def new
    @workspace = Workspace.new
  end

  # POST /workspaces or /workspaces.json
  def create
    @workspace = Workspace.new(workspace_params)

    respond_to do |format|
      if @workspace.save
        format.turbo_stream { render 'workspaces/turbo_stream/create' }
        format.html { redirect_to workspaces_path, notice: 'Workspace was successfully created.' }
        format.json { render :show, status: :created, location: @workspace }
      else
        format.html { render :new }
        format.json { render json: @workspace.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /workspaces/1/edit
  def edit; end

  # PATCH/PUT /workspaces/1 or /workspaces/1.json
  def update
    respond_to do |format|
      if @workspace.update(workspace_params)
        format.turbo_stream { render 'workspaces/turbo_stream/update' }
        format.html { redirect_to workspaces_path, notice: 'Workspace was successfully updated.' }
        format.json { render :show, status: :ok, location: @workspace }
      else
        format.html { render :edit }
        format.json { render json: @workspace.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workspaces/1 or /workspaces/1.json
  def destroy
    @workspace.destroy
    respond_to do |format|
      format.turbo_stream { render 'workspaces/turbo_stream/destroy' }
      format.html { redirect_to workspaces_url, notice: 'Workspace was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def workspace_params
    params.require(:workspace).permit(:title)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_workspace
    @workspace = Workspace.find(params[:id])
  end
end

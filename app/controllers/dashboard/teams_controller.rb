class Dashboard::TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_prof, :only =>[:new, :update, :edit, :create,:destroy]
  before_action :can_edit?, :only =>[:update, :edit, :destroy]

  def can_edit?
    unless current_user.id.to_s == Team.find(params[:id]).owner_id.to_s || current_user.admin?
      render_401
    end
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(params[:team])
    @team.owner_id = current_user.id
    respond_to do |format|
      if @team.save
        format.html { redirect_to dashboard_teams_available_path, notice: 'Turma criada com sucesso.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to panel_team_path(@team.id), notice: 'Turma atualizada com sucesso.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def enroll
    t = Team.find(params[:team][:id])
    unless t.users.include?(current_user)
      if t.code == params[:password]
        t.users << current_user

        t.save!
      else
        @wrong_code_team_id = t.id
      end
    end
    #@teams = Team.all
    @teams = Team.where(active: true)

    render "available"
  end

  def unenroll
    @team = Team.find(params[:id])

    if @team.users.include?(current_user)
      @team.user_ids = @team.user_ids - [current_user.id]
      @team.save!
    end

    redirect_to dashboard_teams_available_path
  end

  def destroy
    @team = Team.find(params[:id])

    if @team.owner_id == current_user.id
      @team.destroy
    end

    redirect_to dashboard_teams_available_path
  end

  def available
    @teams = Team.where(active: true)
    @teams_unavailable = Team.where(active: false)
  end
end

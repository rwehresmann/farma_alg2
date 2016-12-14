class DashboardController < ApplicationController
  layout 'dashboard'
  def home
  end

  def timeline
    init_search
  end

  def search
    init_search
  end

  def tags
    init_search
  end

  def init_search
    @teams = current_user.all_teams
    @questions = current_user.all_questions
    @los = current_user.all_los
    @users = current_user.all_students
    @tags = current_user.all_tags
  end

  def help
  end
end

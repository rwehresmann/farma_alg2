class Dashboard::DashboardController < ApplicationController
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

  def timeline_search
    @as = Answer.search(params,current_user).entries
    @total = @as.count
    @as = @as.first(50)
    @timeline_items = Answer.make_timeline(@as)
    @params=params

    Log.log_search_timeline(current_user.id,params)
    render 'timeline_search_result'
  end

  def tags_search
		@as = Answer.search(params,current_user).entries
		@total = @as.count
		@as = @as.first(50)
    #@as_aat = Answer.search_aat(params,current_user)
		@params =params

		Log.log_search_tag(current_user.id,params)
    render 'tags_search_result'
  end

	def tags_search_aat
		@as_aat = Answer.search_aat(params,current_user)
		@total = @as_aat.count
		@as = @as_aat.first(50)
		render 'tags_search_aat_result'
	end

  def fulltext_search
		if params.has_key?(:page)
			page = params[:page]
		else
			page = 1
		end
    @as = Answer.search(params,current_user,page)
    @button_add = true
    @button_add = false unless params.has_key?(:button_add)
		@params =params

		Log.log_search_simple(current_user.id,params)

    render 'search_result'
  end

  def graph
    init_search
		Log.log_graph_view(current_user.id)
  end

  def graph_search
		@as = Answer.search(params,current_user).entries
		@total = @as.count
		#@as = @as.first(50)
		@params =params

		Log.log_search_graph(current_user.id,params)

    render 'graph_search_result'
  end

	def hide_help
		current_user.show_help = false
		current_user.save
	end
end

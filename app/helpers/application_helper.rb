module ApplicationHelper
  def filter_in_words(params)
	  render(:partial => 'filter_in_words', :locals => {:params => params})
  end
end

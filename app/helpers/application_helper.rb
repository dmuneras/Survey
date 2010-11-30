# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def current_company
    if session[:current_company]
      Company.find( session[:current_company]) 
    end
  end
end

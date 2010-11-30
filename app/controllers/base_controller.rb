class BaseController < ApplicationController

  def index
    unless session[:current_company].nil?
      @current_company = Company.find(session[:current_company])
    end
  end

end

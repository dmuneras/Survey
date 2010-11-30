# -*- coding: utf-8 -*-
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  filter_parameter_logging :password

  helper_method :current_user

  def hash_to_string(h)
    str = []
    h.each do |a,b|
      str << "#{a},#{b}"
    end
    str = str.join(';')
  end

  private
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def is_logged?
    unless current_user
      flash[:notice] = "No se ha logueado aún"
      redirect_to login_path
    end
  end

end

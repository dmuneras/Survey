# -*- coding: utf-8 -*-
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include ApplicationHelper
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  filter_parameter_logging :password

  helper_method :current_user

  def string_to_arrays(s)
    s.split(';').map{|e| e.split(',')}
  end

  def hash_to_string(h)
    h.inject([]){|s,e| s << "#{e.first},#{e.last}"}.join(';')
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

  def admin_logged?
    unless is_admin?
      flash[:notice] = "No puede acceder a este recurso."
      redirect_to root_url
    end
  end

  def company_logged?
    unless current_company or is_admin?
      flash[:notice] = "No puede acceder a este recurso."
      redirect_to root_url
    end
  end

  def user_logged?
    unless current_user or is_admin?
      flash[:notice] = "No puede acceder a este recurso."
      redirect_to root_url
    end
  end

  def is_logged?
    unless current_user or current_company
      flash[:notice] = "No se ha logueado aún."
      redirect_to login_path
    end
  end

end

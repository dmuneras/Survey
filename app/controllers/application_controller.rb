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


  # Convierte un string de la forma "a,b;c,d;..." a un hash de la forma {a => b, c => d, ...}
  def string_to_arrays(s)
    s.split(';').map{|e| e.split(',')}
  end

  # Convierte un hash de la forma {a => b, c => d, ...} a un string de la forma "a,b;c,d;..."
  def hash_to_string(h)
    h.inject([]){|s,e| s << "#{e.first},#{e.last}"}.join(';')
  end

  private
  
  # Retorna la sesión del usuario actual logueado (authlogic)
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  # Retorna el usuario actual que está logueado (authlogic)
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  # Verifica que el admin esté logueado; en caso contrario, redirige a la página principal.
  def admin_logged?
    unless is_admin?
      flash[:notice] = "No puede acceder a este recurso."
      redirect_to root_url
      false
    else
      true
    end
  end

  # Verifica que una compañía (o en su defecto el admin) esté logueado; en caso contrario, redirige a la página principal.
  def company_logged?
    unless current_company or is_admin?
      flash[:notice] = "No puede acceder a este recurso."
      redirect_to root_url
      false
    else
      true
    end
  end

  # Verifica que un usuario (o en su defecto el admin) esté logueado; en caso contrario, redirige a la página principal.
  def user_logged?
    unless current_user or is_admin?
      flash[:notice] = "No puede acceder a este recurso."
      redirect_to root_url
      false
    else
      true
    end
  end

  # Verifica que haya alguien logeado, bien sea usuario o compañía.
  def is_logged?
    unless current_user or current_company
      flash[:notice] = "No se ha logueado aún."
      redirect_to login_path
      false
    else
      true
    end
  end

end

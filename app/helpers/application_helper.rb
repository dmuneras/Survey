# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def is_admin?
    admin_company?(current_company) || admin_company_user?(current_user)
  end

  def admin_company_user?(user)
    unless user.nil?
      if user.company.login == 'eafit'
        return true
      else
        return false
      end
    end
  end

  def admin_company?(company)
    unless company.nil?
      if company.login == 'eafit'
        return true
      else
        return false
      end
    end
  end

  def current_company
    if session[:current_company]
      Company.find( session[:current_company]) 
    end
  end
  
  def hash_to_string(h)
    h.inject([]){|s,e| s << "#{e.first},#{e.last}"}.join(';')
  end

  def string_to_hash(s)
    s.split(';').inject({}) do |h, e| 
      e = e.split(',')
      h[e.first] = e.last.to_f
      h
    end
  end

end

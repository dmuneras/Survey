# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

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
    str = []
    h.each do |a, b|
      str << [a,b].join(',')
    end
    str.join(';')
  end

  def string_to_hash(s)
    h = {}
    s = s.split(';')
    for elem in s do
      tup = elem.split(',')
      h[tup[0]] = tup[1].to_f
    end
    return h
  end
end

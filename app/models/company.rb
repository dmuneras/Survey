# -*- coding: utf-8 -*-
class Company < ActiveRecord::Base
  
  include ApplicationHelper
  
  acts_as_authentic  
  has_many :users , :dependent => :destroy
  belongs_to :subsector

  # TODO no modifica cuando no está logueado CORREGIR
  def calculate_company_averages
    #company_session = CompanySession.new(self)
    #company_session.save
    
    company_avgs = {}
    total_users = 0
    for user in self.users do
      latest_survey = user.survey_records.last
      next unless latest_survey
      user_avgs = string_to_hash latest_survey.averages
      user_avgs.each do |asp, avg|
        company_avgs[asp] ||= 0
        company_avgs[asp] += avg
      end
      total_users += 1
    end
    company_avgs.each {|a,b| company_avgs[a] = b / total_users.to_f}
    company_avgs = hash_to_string company_avgs
    if update_attributes(:averages => company_avgs)
      logger.info("Success!")
    else
      logger.info("Fail :'(")
    end    
    # company_session.destroy
  end
  
  
  def self.find_worst_company_in (companies)
    worst = nil
    min = 101
    for company in companies do
      averages = string_to_hash company.averages
      total_avg = 0
      averages.each do |asp, avg|
        total_avg += avg
      end
      total_avg /= averages.size
      if total_avg < min
        min = total_avg
        worst = company
      end
    end
    return worst
  end

  def self.find_best_company_in (companies)
    best = nil
    max = -1
    for company in companies do
      averages = string_to_hash company.averages
      total_avg = 0
      averages.each do |asp, avg|
        total_avg += avg
      end
      total_avg /= averages.size
      if total_avg > max
        max = total_avg
        best = company
      end
    end
    return best
  end
 
end

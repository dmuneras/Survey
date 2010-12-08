# -*- coding: utf-8 -*-
class Company < ActiveRecord::Base
  
  include ApplicationHelper
  
  acts_as_authentic  
  has_many :users , :dependent => :destroy
  belongs_to :subsector
  
  def calculate_company_averages   
    company_avgs = []
    total_users = 0
    for user in self.users do
      latest_survey = user.survey_records.last
      next unless latest_survey
      user_avgs = latest_survey.averages.split(';')
      (0...Aspect.count).zip(user_avgs) do |asp, avg|
        company_avgs[asp] ||= 0
        company_avgs[asp] += avg.to_f
      end
      total_users += 1
    end
    company_avgs = company_avgs.map {|avg| avg /= total_users.to_f}
    company_avgs = company_avgs.join(';')
    if update_attributes(:averages => company_avgs)
      logger.info("Success!")
    else
      logger.info("Fail :'(")
    end    
  end
  
  
  def self.find_worst_company_in (companies)
    worst = nil
    min = 101
    for company in companies do
      averages = company.averages.split(';')
      total_avg = 0
      for average in averages do
        total_avg += average
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
      averages = company.averages.split(';')
      total_avg = 0
      for average in averages do 
        total_avg += average
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

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
  
  
end

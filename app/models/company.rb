# -*- coding: utf-8 -*-
class Company < ActiveRecord::Base
  
  include ApplicationHelper
  
  acts_as_authentic  
  has_many :users , :dependent => :destroy
  belongs_to :subsector
  before_save :default_values

  # TODO no modifica cuando no está logueado CORREGIR
  def calculate_company_averages
    company_session = CompanySession.new(self)
    company_session.save
    
    company_avgs = {}
    total_users = 0
    for user in self.users do
      latest_survey = user.survey_records.last
      next unless latest_survey
      user_avgs = latest_survey.averages.split(';')
      user_avgs.each do |avg|
        tup = avg.split(',')
        company_avgs[tup[0].to_i] ||= 0
        company_avgs[tup[0].to_i] += tup[1].to_f
      end
      total_users += 1
    end
    company_avgs = company_avgs.each {|a,b| company_avgs[a] = b / total_users.to_f}
    company_avgs = hash_to_string company_avgs
    if update_attributes(:averages => company_avgs)
      logger.info("Success!")
    else
      logger.info("Fail :'(")
    end    
    company_session.destroy
  end
  private
  def default_values
    avgs = {}
    aspects = Aspect.all
    for aspect in aspects do
      avgs[aspect.id] = 0
    end
    self.averages = hash_to_string avgs
  end
    
end

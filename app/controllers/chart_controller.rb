# -*- coding: utf-8 -*-
class ChartController < ApplicationController

  before_filter :is_logged?
  
  def index 
    if current_user
    
    elsif current_company
    
    end
  end

  def show
    @aspects = Aspect.all
    @graph = nil
    that_company = nil
    title = nil
    if current_company 
      if params[:id] == 'best_subsector'
        that_company = find_worst_company_in current_company.subsector.companies
        title = 'Compañía de más alto rendimiento en el subsector'
      elsif params[:id] == 'worst_subsector'
        that_company = find_best_company_in current_company.subsector.companies
        title = 'Compañía de más bajo rendimiento en el subsector'
      elsif params[:id] == 'best_sector'
        that_company = find_best_company_in Company.all
        title = 'Compañía de más alto rendimiento en el sector'
      elsif params[:id] == 'worst sector'
        that_company = find_worst_company_in Company.all
        title = 'Compañía de más bajo rendimiento en el sector'
      end
      generate_radar_chart title, (string_to_hash current_company.averages), (string_to_hash that_company.averages)
    elsif current_user
      if params[:id] == 'user_time'
        title = 'Resultados a través del tiempo'
        prelast_survey = SurveyRecord.before_last_of current_user
        if prelast_survey
          generate_bar_chart title, (string_to_hash current_user.survey_records.last.averages), (string_to_hash prelast_survey.averages)
        end
      elsif params[:id] == 'user_average'
        title = 'Resultados promedio'
        generate_bar_chart title, (averages_of_user current_user)
      end
      # generate_bar_chart title, (averages_of_user current_user)
    end
  end
  
  private
  def generate_bar_chart(the_title, vals1, vals2 = nil)
    respond_to do |wants|
      wants.html {
        @graph = open_flash_chart_object(800,400,url_for(:action => 'show', :format => :json))
      }
      wants.json {
        title = Title.new(the_title)
        chart = OpenFlashChart.new(title) do |c|
          bar_values = []
          vals1.each do |asp, avg|
            bar_values << BarValue.new(avg, nil, 
                                       :tip => Aspect.find(asp).name)            
          end          
          key = nil
          c.set_bg_colour('#FFFFFF')
          y = YAxis.new
          y.set_range(0, 5, 1)
          x = XAxis.new
          x.set_range(1, 5, 1)
          if vals2
            bar_values2 = []
            vals2.each do |asp, avg|
              bar_values2 << BarValue.new(avg, nil,
                                          :tip => Aspect.find(asp).name)
            end
            c << BarGlass.new(:values => bar_values2,
                              :text => 'Penúltima encuesta',
                              :colour => '#00FF00',
                              :on_show => BarOnShow.new('grow-up', 1.0, 1.0))
            key = 'Última encuesta'
          end
          key ||= 'Promedios de encuesta'
          c << BarGlass.new(:values => bar_values,
                            :text => key,
                            :colour => '#FF0000',
                            :on_show => BarOnShow.new('grow-up', 0.5, 0.5))
          c.y_axis = y
          c.x_axis = x
          
          # tooltip = Tooltip.new
          # tooltip.set_proximity
          # c.set_tooltip(tooltip)
          
        end
        render :text => chart, :layout => false        
      }
    end
  end

  def generate_radar_chart(the_title, vals1, vals2)
    respond_to do |wants|
      wants.html {
        @graph = open_flash_chart_object(300,300,url_for(:action => 'show', :format => :json))
      }
      wants.json {
        title = Title.new(the_title)
        chart = OpenFlashChart.new(title) do |c|
          c.set_bg_colour('#FFFFFF')
          dot_values1 = []
          dot_values2 = []

          vals1.each do |asp, avg|
            dot_values1 << DotValue.new(avg, '#000000',
                                    :tip => Aspect.find(asp).name)
          end

          vals2.each do |asp, avg|
            dot_values2 << DotValue.new(avg, '#000000',
                                    :tip => Aspect.find(asp).name)
          end
          c << AreaBase.new(:width => 3,
                            :colour => '#FFF',
                            :loop => true,
                            :values => dot_values1,
                            :fill_alpha => 0.35,
                            :dot_style => SolidDot.new(nil, :dot_size => 4),
                            :on_show => LineOnShow.new('explode', 0.5, 0.5))
          c << AreaBase.new(:width => 2,
                            :colour => '#FF0000',
                            :loop => true,
                            :values => dot_values2,
                            :fill_alpha => 0.35,
                            :dot_style => SolidDot.new(nil, :dot_size => 3),
                            :on_show => LineOnShow.new('explode', 1.0, 1.0))
          spoke_labels = RadarSpokeLabels.new(Array.new(['1','2','3','4','5']))
          r = RadarAxis.new(5,
                            :colour => '#000',
                            :spoke_labels => spoke_labels)
          c.set_radar_axis(r)
          tooltip = Tooltip.new
          tooltip.set_proximity()
          c.set_tooltip(tooltip)                              
        end
        render :text => chart, :layout => false        
      }
    end
  end

  def averages_of_user (user)
    records = SurveyRecord.find_all_by_user_id(user.id)
    vals = {}
    for record in records do
      averages = string_to_hash record.averages      
      averages.each do |asp, avg|
        vals[asp] ||= 0
        vals[asp] += avg
      end
    end
    vals.each{|a, b| vals[a] = b / records.size}
    return vals
  end

  def find_worst_company_in (companies)
    worst = nil
    min = 101
    for company in companies do
      avgs = company.averages.split(';')
      avgs = avgs.map{|a| a.to_f}
      total_avg = avgs.inject{|sum, el| sum + el.to_f}.to_f / avgs.size
      if total_avg < min
        min = total_avg
        worst = company
      end
    end
    return worst
  end

  def find_best_company_in (companies)
    best = nil
    max = -1
    for company in companies do
      avgs = company.averages.split(';')
      avgs = avgs.map{|a| a.to_f}
      total_avg = avgs.inject{|sum, el| sum + el.to_f}.to_f / avgs.size
      if total_avg > max
        max = total_avg
        best = company
      end
    end
    return best
  end

end

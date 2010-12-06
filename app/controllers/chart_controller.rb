# -*- coding: utf-8 -*-
class ChartController < ApplicationController

  before_filter :is_logged?
  
  # TODO validaciones para admin
  def index
    split_params = params[:id].split('_')
    type = split_params.first
    id = split_params.last
    if type == 'company' 
      if current_company.id == id.to_i
        @company = Company.find(id)
      end
    elsif type == 'user' 
      if current_user and current_user.id == id.to_i
        @user = User.find(id)        
      elsif current_company and User.find(id).company_id == current_company.id        
        @user = User.find(id)
      end
    end
  end

  def show    
    @aspects = Aspect.all
    split_params = params[:id].split('_')
    type = split_params.first
    chart_type = split_params[1]
    id = split_params.last
    if type == 'company'
      this_company = Company.find(id)
      if chart_type == 'subbest'
        that_company = find_best_company_in this_company.subsector.companies
        title = 'Compañía de más alto rendimiento en el subsector'
      elsif chart_type == 'subworst'
        that_company = find_worst_company_in this_company.subsector.companies
        title = 'Compañía de más bajo rendimiento en el subsector'
      elsif chart_type == 'best'
        that_company = find_best_company_in Company.all
        title = 'Compañía de más alto rendimiento en el sector'
      elsif chart_type == 'worst'
        that_company = find_worst_company_in Company.all
        title = 'Compañía de más bajo rendimiento en el sector'
      end      
      to_compare = []
      to_compare << this_company
      to_compare << that_company
      generate_radar_chart title, to_compare
    elsif type == 'user'
      this_user = User.find(id)
      if  chart_type == 'time'
        title = 'Resultados a través del tiempo'
        data = this_user.last_surveys 3
        generate_bar_chart title, data.reverse
      elsif chart_type == 'average'
        title = 'Resultados promedio'
        generate_bar_chart title, (this_user.total_average)
      end
    end
  end
  
  private
  def generate_bar_chart(the_title, survey_data)
    respond_to do |wants|
      wants.html {
        @graph = open_flash_chart_object(800,400,url_for(:action => 'show', :format => :json))
      }
      wants.json {
        title = Title.new(the_title)
        chart = OpenFlashChart.new(title) do |c|
          colours = ['#FF0000', '#FFFF00', '#0000FF', '#00FF00', '#00FFFF']
          if survey_data.class == Hash            
            bar_values = []
            survey_data.zip(colours) do |res, colour|
              break unless res
              bar_values << BarValue.new(res.last, nil,
                                         :colour => colour,
                                         :tip => Aspect.find(res.first).name)
            end
            c << BarGlass.new(:values => bar_values,
                              :on_show => BarOnShow.new('grow-up', 0.5, 0.5))
          else
            survey_data.zip(colours) do |survey, colour|
              bar_values = []
              averages = string_to_hash survey.averages
              averages.each do |asp, avg|
                tip = "#{Aspect.find(asp).name}<br>#{survey.date}"
                bar_values << BarValue.new(avg, nil,
                                            :tip => tip)
              end
              c << BarGlass.new(:values => bar_values,
                                :text => survey.date,
                                :colour => colour,
                                :on_show => BarOnShow.new('grow-up', 0.5, 0.5))
            end
          end
          c.set_bg_colour('#FFFFFF')
          y = YAxis.new
          y.set_range(0, 5, 1)
          x = XAxis.new
          x.set_range(1, 5, 1)
          c.y_axis = y
          c.x_axis = x
          
        end
        render :text => chart, :layout => false        
      }
    end
  end

  def generate_radar_chart(the_title, companies)
    respond_to do |wants|
      wants.html {
        @graph = open_flash_chart_object(400,400,url_for(:action => 'show', :format => :json))
      }
      wants.json {
        title = Title.new(the_title)
        chart = OpenFlashChart.new(title) do |c|
          c.set_bg_colour('#FFFFFF')
          colours = ['#FF0000', '#0000FF', '#FFFF00', '#00FF00', '#00FFFF']
          i = 0
          for company in companies do
            values = string_to_hash company.averages
            dot_values = []
            values.each do |asp, avg|
              tip = "#{Aspect.find(asp).name}<br>#{company.name}"
              dot_values << DotValue.new(avg, colours[i],
                                         :tip => tip)
            end
            c << AreaBase.new(:width => 3,
                              :colour => colours[i],
                              :values => dot_values,
                              :fill_alpha => 0.35,
                              :dot_style => SolidDot.new(nil, :dot_size => 4),
                              :text => company.name,
                              :on_show => LineOnShow.new('explode', 0.5, 0.5),
                              :loop => true)
            i += 1
                              
          end
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
  
  
  def find_worst_company_in (companies)
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

  def find_best_company_in (companies)
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

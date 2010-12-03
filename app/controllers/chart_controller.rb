# -*- coding: utf-8 -*-
class ChartController < ApplicationController

  before_filter :is_logged?
  
  # TODO validaciones para admin
  def index
    split_params = params[:id].split('_')
    type = split_params.first
    id = split_params.last
    if type == 'company' 
      if current_company.id == id
        @company = Company.find(id)
      end
    elsif type == 'user' 
      if current_user and current_user.id.to_s == id.to_s
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
        that_company = find_worst_company_in this_company.subsector.companies
        title = 'Compañía de más alto rendimiento en el subsector'
      elsif chart_type == 'subworst'
        that_company = find_best_company_in this_company.subsector.companies
        title = 'Compañía de más bajo rendimiento en el subsector'
      elsif chart_type == 'best'
        that_company = find_best_company_in Company.all
        title = 'Compañía de más alto rendimiento en el sector'
      elsif chart_type == 'worst'
        that_company = find_worst_company_in Company.all
        title = 'Compañía de más bajo rendimiento en el sector'
      end
      generate_radar_chart title, (string_to_hash this_company.averages), (string_to_hash that_company.averages)
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
          if survey_data.class == Hash
            bar_values = []
            survey_data.each do |asp, avg|
              bar_values << BarValue.new(avg, nil,
                                         :tip => Aspect.find(asp).name)
            end
            c << BarGlass.new(:values => bar_values,
                              :text => 'Promedios',
                              :on_show => BarOnShow.new('grow-up', 0.5, 0.5))
          else
            colours = ['#FF0000', '#00FF00', '#0000FF']
            i = 0
            for survey in survey_data do
              bar_values = []
              averages = string_to_hash survey.averages
              averages.each do |asp, avg|
                bar_values << BarValue.new(avg, nil,
                                            :tip => Aspect.find(asp).name)
              end
              c << BarGlass.new(:values => bar_values,
                                :text => survey.created_at,
                                :colour => colours[i],
                                :on_show => BarOnShow.new('grow-up', 0.5, 0.5))
              i += 1
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

  def generate_radar_chart(the_title, vals1, vals2)
    respond_to do |wants|
      wants.html {
        @graph = open_flash_chart_object(400,400,url_for(:action => 'show', :format => :json))
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

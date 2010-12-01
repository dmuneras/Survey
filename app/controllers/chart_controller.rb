# -*- coding: utf-8 -*-
class ChartController < ApplicationController

  before_filter :is_logged?
  
  def index 
    if current_user
    
    elsif current_company
    
    end
  end

  def show
    @graph = nil
    that_company = nil
    title = nil
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
    generate_radar_chart title, (averages_of current_company), (averages_of that_company)
  end
  
  private
  def generate_radar_chart(the_title, vals1, vals2)
    respond_to do |wants|
      wants.html {
        @graph = open_flash_chart_object(300,300,url_for(:action => 'show', :format => :json))
      }
      wants.json {
        title = Title.new(the_title)
        chart = OpenFlashChart.new(title) do |c|
          c << AreaBase.new(:width => 3,
                            :colour => '#FFF',
                            :loop => true,
                            :values => vals1,
                            :fill_alpha => 0.35,
                            :dot_style => SolidDot.new(nil, :dot_size => 4),
                            :on_show => LineOnShow.new('explode', 0.5, 0.5))
          c << AreaBase.new(:width => 2,
                            :colour => '#FF0000',
                            :loop => true,
                            :values => vals2,
                            :fill_alpha => 0.35,
                            :dot_style => SolidDot.new(nil, :dot_size => 3),
                            :on_show => LineOnShow.new('explode', 1.0, 1.0))
          spoke_labels = RadarSpokeLabels.new(Array.new(['Aspecto 1',
                                                        'Aspecto 2',
                                                        'Aspecto 3',
                                                        'Aspecto 4',
                                                        'Aspecto 5']))
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

  def averages_of (company)
    company.averages.split(';').map{|a| a.to_f}
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

  def to_hash(str)
    str = str.split(';')
    elem_hash = {}
    for elem in str do
      tup = elem.split(',')
      elem_hash[tup[0].to_i] = tup[1].to_f
    end
    elem_hash
  end

end

# -*- coding: utf-8 -*-
# Controlador para la generación de gŕaficos de resultados para usuarios y compañías.
class ChartController < ApplicationController

  before_filter :is_logged?
  before_filter :get_aspects, :only => [:generate_bar_chart, :generate_radar_chart]
  
  # Índice se gráficos o resultados que se pueden mostrar. Se genera de acuerdo al parámetro <em>id</em> enviado.
  # * Resultados para un usuario de id=x: <em>user_x</em>
  # * Resultados para una compañía de id=x: <em>company_x</em>
  def index
    split_params = params[:id].split('_')
    type = split_params.first
    id = split_params.last
    if type == 'company' 
      if (current_company and current_company.id == id.to_i) or is_admin?
        @company = Company.find(id)
      end
    elsif type == 'user' 
      if current_user and current_user.id == id.to_i
        @user = User.find(id)        
      elsif current_company and User.find(id).company_id == current_company.id        
        @user = User.find(id)
      elsif is_admin?
        @user = User.find(id)
      end
    end
  end
  
  # Genera un gráfico de acuerdo al parámetro <em>id</em>.
  #
  # Gráficos de compañía con id = x:
  # * Empresa del subsector con más alto rendmiento: <em>company_subbest_x</em>
  # * Empresa del subsector con más bajo rendimiento: <em>company_subworst_x</em>
  # * Empresa del sector con más alto rendimiento: <em>company_best_x</em>
  # * Empresa del sector con más bajo rendimiento: <em>company_worst_x</em>
  # Gráficos de usuario con id = x:
  # * Resultados comparativos por aspecto: <em>user_time_x</em>
  # * Resultados individuales totales: <em>user_average_x</em>
  # El gráfico resultante es generado en @graph.
  def show    
    @aspects = Aspect.all
    split_params = params[:id].split('_')
    type = split_params.first
    chart_type = split_params[1]
    id = split_params.last
    if type == 'company'
      this_company = Company.find(id)
      if chart_type == 'subbest'
        that_company = Company.find_best_company_in this_company.subsector.companies
        title = 'Empresa del subsector con más alto rendimiento'
        @next_chart = "company_subworst_#{id}"
      elsif chart_type == 'subworst'
        that_company = Company.find_worst_company_in this_company.subsector.companies
        title = 'Empresa del subsector con más bajo rendimiento'
        @next_chart = "company_best_#{id}"
        @prev_chart = "company_subbest_#{id}"
      elsif chart_type == 'best'
        that_company = Company.find_best_company_in Company.all
        title = 'Empresa del sector con mayor rendimiento'
        @next_chart = "company_worst_#{id}"
        @prev_chart = "company_subworst_#{id}"
      elsif chart_type == 'worst'
        that_company = Company.find_worst_company_in Company.all
        title = 'Empresa del sector con más bajo rendimiento'
        @prev_chart = "company_best_#{id}"
      end      
      to_compare = []
      to_compare << this_company
      to_compare << that_company if this_company != that_company
      generate_radar_chart title, to_compare
    elsif type == 'user'
      this_user = User.find(id)
      if  chart_type == 'time'
        title = 'Resultados comparativos por Aspecto'
        surveys = this_user.last_surveys 3
        data = []
        dates = []
        for survey in surveys do
          data << survey.averages.split(';').map{|avg| avg.to_f}
          dates << survey.date
        end
        generate_bar_chart title, data.reverse, dates.reverse, true
        @next_chart = "user_average_#{id}"
      elsif chart_type == 'average'
        title = 'Resultados individuales totales'
        generate_bar_chart title, (this_user.total_average)
        @prev_chart = "user_time_#{id}"
      end
    end
  end
  
  private
  # Genera un gráfico de barras para un usuario.
  # [+the_title+] Título para el gráfico.
  # [+survey_data+] Arreglo de datos a graficar (pueden ser varios, ver <em>multiple</em>)
  # [+dates+] Fechas de los datos graficados.
  # [+multiple+] Especifica si se graficarán varios series de datos o una sola
  def generate_bar_chart(the_title, survey_data, dates=nil, multiple=false) #:doc:
    respond_to do |wants|
      wants.html {
        @graph = open_flash_chart_object(800,400,url_for(:action => 'show', :format => :json))
      }
      wants.json {
        title = Title.new(the_title, 
                          :style => "{font-size: 12px; font-weight: bold;}")
        chart = OpenFlashChart.new(title) do |c|
          colours = ['#660099', '#B22400', '#FFB200', '#00B366', '#1C416F']
          unless multiple            
            bar_values = []
            survey_data.zip(@aspects, colours) do |avg, aspect, colour|
              bar_values << BarValue.new(avg, nil,
                                         :colour => colour,
                                         :tip => aspect.name)
            end
            c << BarGlass.new(:values => bar_values,
                              :on_show => BarOnShow.new('grow-up', 0.5, 0.5))
          else
            survey_data.zip(dates, colours) do |survey_avgs, date, colour|
              bar_values = []
              @aspects.zip(survey_avgs) do |asp, avg|
                tip = "#{asp.name}<br>#{date}"
                bar_values << BarValue.new(avg, nil,
                                            :tip => tip)
              end
              c << BarGlass.new(:values => bar_values,
                                :text => date,
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

  # Genera un gráfico de radar para la compañía.
  # [+the_title+] Título del gráfico.
  # [+companies+] Compañías que se compararán en el gráfico de acuerdo a sus promedios por aspecto.
  def generate_radar_chart(the_title, companies) #:doc:
    respond_to do |wants|
      wants.html {
        @graph = open_flash_chart_object(800,400,url_for(:action => 'show', :format => :json))
      }
      wants.json {
        title = Title.new(the_title, 
                          :style => "{font-size: 12px; font-weight: bold;}")
        chart = OpenFlashChart.new(title) do |c|
          c.set_bg_colour('#FFFFFF')
          colours = ['#FF0000', '#0000FF', '#FFFF00', '#00FF00', '#00FFFF']
          companies.zip(colours) do |company, colour|
            values = company.averages.split(';')
            dot_values = []
            company_name = (company == current_company or is_admin?) ? company.name : 'Otra'
            @aspects.zip(values) do |asp, avg|              
              tip = "#{asp.name}<br>#{company_name}"
              dot_values << DotValue.new(avg, colour,
                                         :tip => tip)
            end
            c << AreaBase.new(:width => 3,
                              :colour => colour,
                              :values => dot_values,
                              :fill_alpha => 0.35,
                              :dot_style => SolidDot.new(nil, :dot_size => 4),
                              :text => company_name,
                              :on_show => LineOnShow.new('explode', 0.5, 0.5),
                              :loop => true)
                              
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

  def get_aspects
    @aspects = Aspect.all(:order => 'number')
  end

end

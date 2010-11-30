class ChartController < ApplicationController

  def show
    respond_to do |wants|
      wants.html {
        @graph = open_flash_chart_object(600, 600, url_for(:action => 'show', :format => :json))
      }
      wants.json {
        title = Title.new("Aspectos")
        chart = OpenFlashChart.new(title) do |c|
          array1 = []
          array2 = []
          for i in (0..4) do
            array1[i] = rand * 3 + 2
            array2[i] = rand * 2 + 1
          end
          c << AreaBase.new(:width => 5,
                            :colour => '#FFF',
                            :loop => true,
                            :values => array1,
                            :fill_alpha => 0.35,
                            :dot_style => SolidDot.new(nil, :dot_size => 4),
                            :on_show => LineOnShow.new('explode', 0.5, 0.5))
          c << AreaBase.new(:width => 5,
                            :colour => '#FF0000',
                            :loop => true,
                            :values => array2,
                            :fill_alpha => 0.35,
                            :dot_style => SolidDot.new(nil, :dot_size => 4),
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

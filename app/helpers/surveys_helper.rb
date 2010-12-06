module SurveysHelper

  def fill_aspects(current_aspect)
    content_tag(:table, :id => 'all-aspect') do
      content_tag(:tr) do
        Aspect.all.inject([]) do |c, asp|
          c << content_tag(:td, asp.number, :title => asp.name, :id => ('current-aspect' if asp == current_aspect))         
        end
      end
    end
  end

end

module OpenFlashChart
  class AreaBase < Base
    def initialize args={}
      super
      @type = "area"      
    end

    def set_fill_colour(color)
      @fill = color
    end 

    def set_loop
      @loop = true
    end
  end
end

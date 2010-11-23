module OpenFlashChart

  class Chart < Base
    def initialize( title=nil, args={})
      super args
      @title = title      
    end    
  end

  class OpenFlashChart < Chart
  end

end

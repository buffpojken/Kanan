module Paperclip
   module Interpolations
      module Rails
        def self.root(x=nil,y=nil)
          File.join(File.dirname(__FILE__), '..')
        end         
        def self.rails_env(x=nil,y=nil)
          nil
        end
      end
   end  
end
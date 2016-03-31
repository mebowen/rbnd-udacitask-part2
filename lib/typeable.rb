module Typeable
    
    def type
        if self.class.name == "EventItem"
            type = "event"
        elsif self.class.name == "TodoItem"
            type = "todo"
        elsif self.class.name == "LinkItem"
            type = "link"
        else
            raise UdaciListErrors::InvalidItemType
        end 
        return type
    end 
    
    def format_type
        case self.type         
        when "event"
            "event: "
        when "todo"
            "to do: "
        when "link"
            "link: "
        else
            "unknown item type: "
        end
    end 
    
end

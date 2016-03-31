class TodoItem
  include Listable
  include Typeable 
  attr_reader :description, :due, :priority
  
  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
  end
  
  def priority_order
    case priority
      when "high"
        1
      when "medium"
        2
      when "low"
        3
      else
        4
    end
  end
  
  def due_date
    @due = self.due
  end
    
  def details
    format_type + 
    format_description(@description) + 
    "due: " +
    format_date(@due) +
    format_priority
  end
end

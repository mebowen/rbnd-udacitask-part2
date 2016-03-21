class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]
    @items = []
  end
  
  def add(type, description, options={})
    type = type.downcase
    if ["todo", "event", "link"].include?(type)
      if type == "todo"
        if options.key?(:priority)
           if ["low", "medium", "high"].include?(options[:priority])
             @items.push TodoItem.new(description, options) 
           else
             raise UdaciListErrors::InvalidPriorityValue
           end
        else 
          @items.push TodoItem.new(description, options) 
        end
      elsif type == "event"
        @items.push EventItem.new(description, options)
      elsif type == "link"
        @items.push LinkItem.new(description, options)
      end
    else
      raise UdaciListErrors::InvalidItemType
    end
  end
  
  def delete(index)
    if index >= 0 and index < items.length 
      @items.delete_at(index - 1)
    else
      raise UdaciListErrors::IndexExceedsListSize
    end
  end
  
  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
end

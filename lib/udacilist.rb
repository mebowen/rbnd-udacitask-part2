class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @items ||= []
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
      puts "#{position + 1} #{item.details}"
    end
  end
  
  def filter(item_type)
    items_to_display = @items.select { |item| item.type == item_type }
    if items_to_display.empty?
      puts "There are no #{item_type} items."
    else
      items_to_display.each do |item|
        puts "#{item.details}"
      end
    end
  end
  
  def filter_by_priority
    todo_items = @items.select {|item| item.type == "todo"}
    items_by_priority = todo_items.sort_by { |item| item.priority_order}
    items_by_priority.each do |item|
      puts "#{item.details}"
    end
  end 

  def filter_by_due_date
    todo_items = @items.select {|item| item.type == "todo" && !item.due_date.nil?}
    todo_items_without_due_date = @items.select {|item| item.type == "todo" && item.due_date.nil?}
    items_with_due_date = todo_items.sort_by { |item| item.due_date.to_s}
    items_by_due_date = items_with_due_date + todo_items_without_due_date
    items_by_due_date.each do |item|
      puts "#{item.details}"
    end
  end 
  
end


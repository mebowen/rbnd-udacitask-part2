class LinkItem
  include Listable
  include Typeable 
  attr_reader :description, :site_name

  def initialize(url, options={})
    @description = url
    @site_name = options[:site_name]
  end
  
  def details
    format_type + 
    format_description(@description) + 
    "site name: " + 
    format_name(@site_name)
  end
end

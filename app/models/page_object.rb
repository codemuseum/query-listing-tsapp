class PageObject < ActiveRecord::Base
  include ThriveSmartObjectMethods
  
  self.caching_default = :page_object_update 
  #[in :forever, :page_object_update, :any_page_object_update, 'data_update[datetimes]', :never, 'interval[5]']
  
  # Override caching information to be on data_update of the data path
  def caching
    @caching = update_frequency > 0 ? "interval[#{update_frequency}]" : (data_path.blank? ? :page_object_update : "data_update[#{data_path}]")
  end
  
  attr_accessor :full_listings
  
  def fetch_data
    self.full_listings = data_path.blank? ? [] : self.site.find_data(data_path, request_options)
  end
  
  protected
    def request_options
      hash = { :include => [:url, :name, :description, :picture] }
      hash[:order] = { order_by => order_direction || :asc } unless order_by.blank?
      hash[:limit] = limit || 10
      hash
    end
  
end

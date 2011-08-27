Spree::BaseController.class_eval do
  before_filter :set_connection
  
  def set_connection
    config = Spree::MultiVendor::Config
    
    database = config.database_prefix + request.host.gsub('.', '_')
    ActiveRecord::Base.establish_connection(
      :adapter => config.adapter,
      :database => database,
      :username => config.username,
      :password => config.password,
      :host => config.host
    )
  end
end

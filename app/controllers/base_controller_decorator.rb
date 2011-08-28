Spree::BaseController.class_eval do
  before_filter :set_connection
  
  def set_connection
    config = Spree::MultiVendor::Config
    
    config.current_database = config.database_prefix + request.host.gsub('.', '_')
    if config.database_exist?
      ActiveRecord::Base.establish_connection(config.connection_hash)
    else
      render :file => "public/404.html", :status => 404, :layout => false
    end
  end
end

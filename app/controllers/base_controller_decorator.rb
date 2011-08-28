Spree::BaseController.class_eval do
  before_filter :set_connection
  
  def set_connection
    config = Spree::MultiVendor::Config
    
    database = config.database_prefix + request.host.gsub('.', '_')
    databases = []
    IO.popen("mysql -u #{config.username} -p#{config.password}<< EOF
      show databases;
      exit
    EOF") do |pipe|
      databases = pipe.read.split("\n")
    end
    
    if databases.include? database
      ActiveRecord::Base.establish_connection(
        :adapter => config.adapter,
        :database => database,
        :username => config.username,
        :password => config.password,
        :host => config.host
      )
    else
      render :file => "public/404.html", :status => 404, :layout => false
    end
  end
end

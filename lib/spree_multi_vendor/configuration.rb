class Spree::MultiVendor::Configuration
  attr_accessor :database_prefix, :adapter, :host, :username, :password, :encoding,
                :current_database
  
  def initialize(attributes = {})
    attributes.each do |key, value|
      send("#{key}=".to_sym, value) if respond_to?("#{key}=")
    end
  end
  
  def databases_matched
    all_databases.select { |database| database.start_with?(database_prefix) }
  end
  
  def database_exist?
    databases_matched.include? current_database
  end
  
  def connection_hash(database = current_database)
    {
      "database" => database,
      "adapter" => adapter,
      "host" => host,
      "username" => username,
      "password" => password,
      "encoding" => encoding
    }
  end
  
  def connections_hash
    databases_matched.collect { |database| connection_hash(database) }
  end
  
  def self.configure(&block)
    config = self.new
    block.arity < 1 ? config.instance_eval(&block) : block.call(config)
    config
  end
  
  private 
  def all_databases
    IO.popen("mysql -u #{username} -p#{password}<< EOF
      show databases;
      exit
    EOF") do |pipe|
      pipe.read.split("\n")
    end
  end
end

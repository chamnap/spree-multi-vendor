class Spree::MultiVendor::Configuration
  attr_accessor :database_prefix, :adapter, :username, :password, :host
  
  def initialize(attributes = {})
    attributes.each do |key, value|
      send(key.to_sym, value)
    end
  end
  
  def self.configure(&block)
    config = self.new
    block.arity < 1 ? config.instance_eval(&block) : block.call(config)
    config
  end
end


require 'spree_core'
require 'spree_multi_vendor_hooks'
require 'spree_multi_vendor/configuration'

Spree::MultiVendor::Config = Spree::MultiVendor::Configuration.new(YAML.load_file("config/database.yml")["production"])

module SpreeMultiVendor
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end

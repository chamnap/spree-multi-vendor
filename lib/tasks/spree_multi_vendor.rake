# add custom rake tasks here
namespace :multi do
  namespace :db do
    desc "Migrate multiple databases (options: VERSION=x, VERBOSE=false)"
    task :migrate do |t, args|
      Spree::MultiVendor::Config.connections_hash.each do |hash|
        puts "Migrating database #{hash["database"]}"
        
        ActiveRecord::Base.establish_connection(hash)
        Rake::Task["db:migrate"].reenable
        Rake::Task["db:migrate"].invoke
      end
    end
  end
end

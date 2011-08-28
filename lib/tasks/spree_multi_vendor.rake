# add custom rake tasks here
namespace :multi do
  namespace :db do
    desc "Migrate multiple databases (options: VERSION=x, VERBOSE=false)"
    task :migrate do |t, args|
      migration('db:migrate')
    end
    
    task 'migrate:up' do |t, args|
      migration('db:migrate:up')
    end
    
    task 'migrate:down' do |t, args|
      migration('db:migrate:down')
    end
    
    def migration(task)
      Spree::MultiVendor::Config.connections_hash.each do |hash|
        puts "Migrating database #{hash['database']}..."
        
        ActiveRecord::Base.establish_connection(hash)
        Rake::Task[task].reenable
        Rake::Task[task].invoke
      end
    end
  end
end

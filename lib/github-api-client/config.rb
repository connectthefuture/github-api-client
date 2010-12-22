module GitHub
  # Keeps all the configuration stuff
  module Config
    # Constant with defined all the paths used in the application
    Path = {:dir => ENV['HOME'] + "/.github", :dbfile => ENV['HOME'] + "/.github/github.db", :migrations => Gem.loaded_specs['github-api-client'].full_gem_path +  "/db/migrate", :secrets => ENV['HOME'] + "/.github" + "/secrets.yml"} 
    
    if Dir.pwd != Gem.loaded_specs['github-api-client'].full_gem_path
      Version = File.read(Gem.loaded_specs['github-api-client'].full_gem_path + "/VERSION")
    else
      Version = File.read(Dir.pwd + "/VERSION")
    end
    VERSION = Version
    
    # Secrets array, uses env vars if defined
    Secrets = {"login" => ENV['GITHUB_USER'], "token" => ENV['GITHUB_TOKEN']} if ENV['GITHUB_USER'] && ENV['GITHUB_TOKEN']
    begin
      Secrets ||= YAML::load_file(GitHub::Config::Path[:secrets])['user']
    rescue Errno::ENOENT
      # Eye candy with rainbow
      puts <<-report
You have two ways of defining your user to have authenticated access to your API:
  #{"1.".color(:cyan)} Put a file in: #{GitHub::Config::Path[:secrets].color(:blue).bright}
    Define in yaml:
      #{"user".color(:yellow).bright}:
        #{"login".color(:green).bright}: #{"your_login".color(:magenta)}
        #{"token".color(:blue).bright}: #{"your_token".color(:magenta)}
  #{"2.".color(:cyan)} Put #{"GITHUB_USER".color(:green).bright} and #{"GITHUB_TOKEN".color(:blue).bright} in your environment, so github-api-client can read it.
  
      report
    end
    Secrets ||= nil
    
    Options = {:verbose => false}
    
    # Sets up the database and migrates it
    # @return [nil]
    def self.setup
      Dir.mkdir GitHub::Config::Path[:dir] rescue nil
      ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database => GitHub::Config::Path[:dbfile]
      ActiveRecord::Migrator.migrate(GitHub::Config::Path[:migrations], nil)
    end
  end
end
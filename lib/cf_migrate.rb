require "cf_migrate/version"

module CfMigrate
  class Migrate
    def check
      tmp = Dir.chdir("db/")
      sprocs = parse_folder("sprocs/")
    
      puts "Sprocs to Build: #{sprocs}"
    end

    private 

    def parse_folder(folder)
  	  tmp = Dir.chdir(folder)
      files = `git ls-files --others --modified | grep '\.sql$'`.split($/)

      return files
    end
  end
end
require "cf_migrate/version"

module CfMigrate
  class Migrate
    def check
      sprocs = parse_folder("db/sprocs/")
      functions = parse_folder("db/functions/")
      views = parse_folder("db/views/")
    
      puts "Sprocs to Build: #{sprocs}"
      puts "Functions to Build: #{functions}"
      puts "Views to Build: #{views}"
    end

    private 

    def parse_folder(folder)
  	  tmp = Dir.chdir(folder)
      files = `git ls-files --others --modified | grep '\.sql$'`.split($/)

      tmp = Dir.chdir("/")

      return files
    end
  end
end
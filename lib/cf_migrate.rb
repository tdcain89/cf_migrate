require "cf_migrate/version"

module CfMigrate
  class Migrate
    def check
      tmp = Dir.chdir("db/")
      sprocs = parse_folder("sprocs/")
      functions = parse_folder("../functions/")
      views = parse_folder("../views/")
    
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
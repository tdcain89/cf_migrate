require "cf_migrate/version"

ROOT_DIR = Dir.pwd
TIME_OF_RUN = Time.now.strftime("%Y%m%d%H%M%S")

module CfMigrate
  class Migrate
    def build_migration
      if Dir.exists?("db/")
        File.open("db/migrations/#{TIME_OF_RUN}_migrateQueue_up.sql", 'w') {|f| f.write(get_migration_content + "GO") }
      end
    end

    def get_migration_content
      objects = ["functions", "sprocs", "views"]
      content = ""
      objects.each do |type|
        tmp = parse_folder("db/#{type}/")
	    if tmp.is_a?(Array)
	      tmp.each do |curr_file|
	        content = content + "INSERT INTO dbo.migrateQueue ( id, migrationType, name) SELECT newid(), '#{type}', '#{curr_file}'\n"
	      end
        end
      end
      
      return content
    end

    private 

    def parse_folder(folder)
  	  files = ""

  	  if Dir.exists?(folder)
  	    tmp = Dir.chdir(folder)
        files = `git ls-files --others --modified | grep '\.sql$'`.split($/)
        tmp = Dir.chdir(ROOT_DIR)
      end

      return files
    end
  end
end
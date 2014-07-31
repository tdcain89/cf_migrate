require "cf_migrate/version"

ROOT_DIR = Dir.pwd
TIME_OF_RUN = Time.now.strftime("%Y%m%d%H%M%S")

module CfMigrate
  class Migrate
    def build_migration
      File.open("db/migrations/#{TIME_OF_RUN}_migrateQueue.sql", 'w') {|f| f.write(get_migration_content + "GO") }
    end

    def get_migration_content
      objects = ["functions", "sprocs", "views"]
      objects.each do |type|
        tmp = parse_folder("db/#{type}/")
	    tmp.each do |curr_file|
	      content = content + "INSERT INTO dbo.migrateQueue ( id, type, file) SELECT newid(), #{type}, #{curr_file}\n"
	    end
      end
      
      return content
    end

    private 

    def parse_folder(folder)
  	  tmp = Dir.chdir(folder)
      files = `git ls-files --others --modified | grep '\.sql$'`.split($/)
      tmp = Dir.chdir(ROOT_DIR)
      
      return files
    end
  end
end
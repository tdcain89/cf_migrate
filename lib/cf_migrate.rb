require "cf_migrate/version"

ROOT_DIR = Dir.pwd
TIME_OF_RUN = Time.now.strftime("%Y%m%d%H%M%S")

module CfMigrate
  class Migrate
    def build_all_objects
      sprocs = get_sprocs
      
      sprocs.each do |sproc|
        File.open("db/migrations/#{TIME_OF_RUN}_migrateQueue.sql", 'w') {|f| f.write("INSERT INTO dbo.migrateQueue ( id, type, file) SELECT newid(), sprocs, #{sproc}\n") }
      end

      File.open("db/migrations/#{TIME_OF_RUN}_migrateQueue.sql", 'w') {|f| f.write("GO") }
    end

    def get_sprocs
      sprocs = parse_folder("db/sprocs/")
    end

    def get_functions
      functions = parse_folder("db/functions/")
    end

    def get_views
      views = parse_folder("db/views/")
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
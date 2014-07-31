require "cf_migrate/version"

ROOT_DIR = Dir.pwd

module CfMigrate
  class Migrate
    def build_all_objects
      sprocs = get_sprocs
      
      sprocs.each do |sproc|
        tmp_content = File.Open(sproc, 'r')
        File.open("allObjects.sql", 'w') {|f| f.write(tmp_content) }
      end
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
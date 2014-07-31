require "cf_migrate/version"

module CfMigrate
  def build

  end

  def check
    sprocs = parse_folder("db/sprocs")
    functions = parse_folder("db/functions")
    views = parse_folder("db/views")
    
    puts "Sprocs to Build: #{sprocs}"
    puts "Functions to Build: #{functions}"
    puts "Views to Build: #{views}"
  end

  private 

  def parse_folder(folder)
  	tmp = Dir.glob("#{folder}/**").sort_by {|f| File.mtime(f)}.reverse
    tmp.reject {|f| File.mtime(f).strftime("%F") != Time.now.strftime("%F")}

    return tmp
  end
end
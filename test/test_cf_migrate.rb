require 'test/unit'
require 'cf_migrate'

class CfMigrateTest < Test::Unit::TestCase
  #
  #
  # Just want to assert that this method does not error
  # if the directories in question do not exist
  def test_build_migration
  	migration_object = CfMigrate::Migrate.new
  	assert_equal nil, migration_object.build_migration
  end

  #
  #
  # Again, want to make sure this works out of the box without
  # requiring the directories to exist
  def test_get_migration_content
  	migration_object = CfMigrate::Migrate.new
    assert_equal "", migration_object.get_migration_content
  end
end
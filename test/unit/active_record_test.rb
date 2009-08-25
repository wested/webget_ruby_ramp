require 'test/unit'
require 'ramp'
require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:")

ActiveRecord::Schema.define(:version => 1) do
  create_table :foos do |t|
    t.string :a
    t.string :b
    t.string :c
  end
end

class Foo < ActiveRecord::Base
end

class ActiveRecordTest < Test::Unit::TestCase

  def test_create_or_update
  end

  def test_create_or_update_by
  end

  def seed
  end

end

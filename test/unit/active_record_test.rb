require 'test/unit'
require 'ramp'
require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

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

  def test_prelim_count
    assert_equal(0,Foo.count)
  end

  def test_prelim_create
    f=Foo.new
    f.a='aa'
    f.b='bb'
    f.c='cc'
    f.save
    assert_equal(1,Foo.count)    
  end

  def test_seed_with_create
    n1=Foo.count
    Foo.seed(:a,{:a=>'xxx',:b=>'yyy'})
    n2=Foo.count
    assert_equal(n1+1,n2)    
  end

  def test_seed_with_update
    n1=Foo.count
    f1=Foo.find(:first)
    Foo.seed(:a,{:a=>f1.a,:b=>'bbb'})
    n2=Foo.count
    assert_equal(n1,n2)    
  end

end

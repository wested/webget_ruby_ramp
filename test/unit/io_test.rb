require 'test/unit'
require 'ramp'

class IOTest < Test::Unit::TestCase

 def test_load_dir_files
   dirpath='test/unit/io_test*'
   expect=["test/unit/io_test.rb","test/unit/io_test.txt"]
   actual=Dir[dirpath].sort
   assert_equal(expect,actual,"Dir[#{dirpath}] expects test data files")
 end

 def test_readline
  filename=Dir['test/unit/io_test.txt'].first
  f=File.open(filename)
  expect=["aa","bb","cc"]
  actual=f.readrow("\n","-")
  assert_equal(expect,actual)
 end

 def test_readlines
  filename=Dir['test/unit/io_test.txt'].first
  expect=[["aa","bb","cc"],["dd","ee","ff"],["gg","hh","ii"]]
  actual=IO.readrows(filename,"\n","-")
  assert_equal(expect,actual)
 end

end


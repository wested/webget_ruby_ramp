require 'test/unit'
require 'ramp'

class IOTest < Test::Unit::TestCase

 def test_load_dir_files
   dirpath='test/unit/io_test*'
   expect=["test/unit/io_test.rb","test/unit/io_test.txt"]
   actual=Dir[dirpath].sort
   assert_equal(expect,actual,"Dir[#{dirpath}] expects test data files")
 end

 def test_readrow
  filename=Dir['test/unit/io_test.txt'].first
  f=File.open(filename)
  assert_equal(["A1","B1","C1"],f.readrow(:row=>"=",:col=>"-"))
  assert_equal(["A2","B2","C2"],f.readrow(:row=>"=",:col=>"-"))
  assert_equal(["A3","B3","C3"],f.readrow(:row=>"=",:col=>"-"))
 end

 def test_readrows
  filename=Dir['test/unit/io_test.txt'].first
  expect=[["A1","B1","C1"],["A2","B2","C2"],["A3","B3","C3"]]
  actual=IO.readrows(filename,:row=>"=",:col=>"-")
  assert_equal(expect,actual)
 end

end


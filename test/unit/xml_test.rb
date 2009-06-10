require 'test/unit'
require 'ramp'

class XMLTest < Test::Unit::TestCase

 def test_load_dir_files
  dirpath='test/unit/xml_test_*.yml'
  expect=["test/unit/xml_test_1.yml","test/unit/xml_test_2.yml"]
  actual=Dir[dirpath].sort
  assert_equal(expect,actual,"Dir[#{dirpath}] expects test data files")
 end

 def test_load_dir
  dirpath='test/unit/xml_test_*.xml'
  expect="abcdef"
  actual=''
  XML.load_dir(dirpath){|doc| actual << doc.to_s }
  assert_equal(expect,actual,'XML.load_dir')
 end

end


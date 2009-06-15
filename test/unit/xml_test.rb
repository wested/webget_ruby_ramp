require 'test/unit'
require 'ramp'

class XMLTest < Test::Unit::TestCase

 def test_load_dir_files
  dirpath='test/unit/xml_test_*.xml'
  expect=["test/unit/xml_test_1.xml","test/unit/xml_test_2.xml"]
  actual=Dir[dirpath].sort
  assert_equal(expect,actual,"Dir[#{dirpath}] expects test data files")
 end

 def test_load_dir
  dirpath='test/unit/xml_test_*.xml'
  expect="abcdef"
  actual=''
  XML.load_dir(dirpath){|doc| doc.elements.each('foo/bar'){|e| actual+=e.attributes['x']}}
  assert_equal(expect,actual,'XML.load_dir')
 end

 def test_attributes_hash
   doc=REXML::Document.new('<foo a="b" c="d" e="f"/>')
   expect={"a"=>"b","c"=>"d","e"=>"f"}
   actual=doc.elements['foo'].attributes.hash
   assert_equal(expect,actual,'XML attributes hash')
 end

end

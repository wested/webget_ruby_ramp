require 'test/unit'
require 'webget_ruby_ramp'

class XMLTest < Test::Unit::TestCase

 MYDIR=File.join('test','webget_ruby_ramp')
 @@formatter=REXML::Formatters::Default.new

 def test_load_dir_files
   dirpath=File.join(MYDIR,'xml_test_*.xml')
   expect=[File.join(MYDIR,'xml_test_1.xml'),File.join(MYDIR,'xml_test_2.xml')]
   actual=Dir[dirpath].sort
   assert_equal(expect,actual,"Dir[#{dirpath}] expects test data files")
 end

 def test_load_dir
   dirpath=File.join(MYDIR,'xml_test_*.xml')
   expect="abcdef"
   actual=''
   XML.load_dir(dirpath){|doc| doc.elements.each('foo/bar'){|e| actual+=e.attributes['x']}}
   assert_equal(expect,actual,'XML.load_dir')
 end

 def test_load_elements
   dirpath=File.join(MYDIR,'xml_test_*.xml')
   expect="<bar x='a'/><bar x='b'/><bar x='c'/><bar x='d'/><bar x='e'/><bar x='f'/>"
   actual=''
   XML.load_elements(dirpath,'foo/bar'){|elem| actual+=elem.to_s }
   assert_equal(expect,actual,'XML.load_elements')
 end

 def test_load_attributes
   dirpath=File.join(MYDIR,'xml_test_*.xml')
   expect="xaxbxcxdxexf"
   actual=''
   XML.load_attributes(dirpath,'foo/bar'){|attributes| actual+=attributes.sort.to_s }
   assert_equal(expect,actual,'XML.load_attributes')
 end

 def test_load_attributes_hash
   dirpath=File.join(MYDIR,'xml_test_*.xml')
   expect="xaxbxcxdxexf"
   actual=''
   XML.load_attributes_hash(dirpath,'foo/bar'){|attributes_hash| actual+=attributes_hash.to_s }
   assert_equal(expect,actual,'XML.load_attributes_hash')
 end

 def test_attributes_to_hash
   doc=REXML::Document.new('<foo a="b" c="d" e="f"/>')
   expect={"a"=>"b","c"=>"d","e"=>"f"}
   actual=doc.elements['foo'].attributes.to_hash
   assert_equal(expect,actual,'XML attributes hash')
 end

 def test_element_remove_attributes
   xml="<foo a='b' c='d'><bar e='f' g='h'>text</bar></foo>"
   expect="<foo><bar e='f' g='h'>text</bar></foo>"
   doc=REXML::Document.new(xml)
   doc.elements[1].remove_attributes
   actual=doc.to_s
   assert_equal(expect,actual)
 end

 def test_document_remove_attributes
   xml="<foo a='b' c='d'><bar e='f' g='h'>text</bar></foo>"
   expect="<foo><bar>text</bar></foo>"
   doc=REXML::Document.new(xml)
   doc.remove_attributes
   actual=doc.to_s
   assert_equal(expect,actual)
 end

 def test_strip_all
   s="<foo a=b c=d><!--comment-->Hello<!-[if bar]>Microsoft<![endif]>World</foo>"
   expect="<foo>HelloWorld</foo>"
   actual=XML.strip_all(s)
   assert_equal(expect,actual)
 end 

 def strip_attributes
  s="<foo a=b c=d e=f>Hello</foo>"                                                                          
  expect="<foo>Hello</foo>" 
  actual=XML.strip_attributes(s) 
  assert_equal(expect,actual)
 end

 def test_strip_comments
   s="Hello<!--comment-->World" 
   expect="HelloWorld"
   actual=XML.strip_comments(s)
   assert_equal(expect,actual)
 end

 def test_strip_microsoft
   s="Hello<!-[if foo]>Microsoft<![endif]->World"     
   expect="HelloWorld"    
   actual=XML.strip_microsoft(s)
   assert_equal(expect,actual)
 end

 def test_strip_unprintables
   s="HelloWorld" #TODO create test that has unprintables
   expect="HelloWorld"
   actual=XML.strip_unprintables(s)
   assert_equal(expect,actual)
 end
   
 def test_strip_msword
   clean=File.open(File.join(MYDIR,"xml_test_msword_clean.html"),"rb")
   dirty=File.open(File.join(MYDIR,"xml_test_msword_dirty.html"),"rb")
   expect=clean.read
   actual=XML.strip_all(dirty.read)
   assert_equal(expect,actual)
 end

end


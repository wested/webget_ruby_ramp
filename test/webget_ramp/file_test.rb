require 'test/unit'
require 'webget_ramp'

class FileTestCase < Test::Unit::TestCase

  def test_load_dir_files
    filename='/a/b/c.d'
    dirname=File.dirname(filename)
    expect=File.join(dirname,'x','y','z')   
    actual=File.joindir(filename,'x','y','z')
    assert_equal(expect,actual,"filename:#{filename} dirname:#{dirname}")
  end

end


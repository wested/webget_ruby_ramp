require 'test/unit'
require 'ramp'

class YAMLTest < Test::Unit::TestCase

 def test_load_dir_pairs
  dirpath='test/unit/yaml_test_*.yml'

  # Ensure the test files are available
  expect_filenames=["test/unit/yaml_test_1.yml","test/unit/yaml_test_2.yml"]
  actual_filenames=Dir[dirpath].sort
  assert_equal(expect_filenames,actual_filenames,"Dir[#{dirpath}] expects test data files")

  # Load the test files
  expect_out='abcdefghijklmnopqr'
  actual_out=''
  YAML.load_dir_pairs(dirpath){|k,v| actual_out << "#{k}" }
  assert_equal(expect_out,actual_out,'YAML.load_dir_pairs')
 end


end


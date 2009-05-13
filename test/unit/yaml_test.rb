require 'test/unit'
require 'ramp'

class YAMLTest < Test::Unit::TestCase

 def test_load_dir_files
  dirpath='test/unit/yaml_test_*.yml'
  expect=["test/unit/yaml_test_1.yml","test/unit/yaml_test_2.yml"]
  actual=Dir[dirpath].sort
  assert_equal(expect,actual,"Dir[#{dirpath}] expects test data files")
 end

 def test_load_dir
  dirpath='test/unit/yaml_test_*.yml'
  expect="aa1a10a2a20a3a30bb1b10b2b20b3b30cc1c10c2c20c3c30dd1d10d2d20d3d30ee1e10e2e20e3e30ff1f10f2f20f3f30gg2g20g3g30g1g10hh3h30h1h10h2h20ii1i10i2i20i3i30kk1k10k2k20k3k30ll1l10l2l20l3l30jj1j10j2j20j3j30mm1m10m2m20m3m30nn1n10n2n20n3n30oo1o10o2o20o3o30pp1p10p2p20p3p30qq1q10q2q20q3q30rr2r20r3r30r1r10"
  actual=''
  YAML.load_dir(dirpath){|doc| actual << "#{k}" }
  assert_equal(expect,actual,'YAML.load_dir')
 end

end


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
  expect=[
   "a:a1,a10,a2,a20,a3,a30b:b1,b10,b2,b20,b3,b30c:c1,c10,c2,c20,c3,c30", 
   "d:d1,d10,d2,d20,d3,d30e:e1,e10,e2,e20,e3,e30f:f1,f10,f2,f20,f3,f30", 
   "g:g1,g10,g2,g20,g3,g30h:h1,h10,h2,h20,h3,h30i:i1,i10,i2,i20,i3,i30",
   "k:k1,k10,k2,k20,k3,k30l:l1,l10,l2,l20,l3,l30j:j1,j10,j2,j20,j3,j30",
   "m:m1,m10,m2,m20,m3,m30n:n1,n10,n2,n20,n3,n30o:o1,o10,o2,o20,o3,o30", 
   "p:p1,p10,p2,p20,p3,p30q:q1,q10,q2,q20,q3,q30r:r1,r10,r2,r20,r3,r30", 
  ]
  actual=[]
  YAML.load_dir(dirpath){|doc| actual << doc.keys.map{|k| v=doc[k]; "#{k}:#{v.sort.join(",")}" }.join("") }
  actual.sort!
  assert_equal(expect,actual,'YAML.load_dir')
 end

end


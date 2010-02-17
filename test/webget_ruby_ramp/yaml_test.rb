require 'test/unit'
require 'webget_ruby_ramp'

class YAMLTest < Test::Unit::TestCase

 MYDIR=File.join('test','webget_ruby_ramp')

 def test_load_dir_files
  dirpath=File.join(MYDIR,'yaml_test_*.yml')
  expect=[File.join(MYDIR,'yaml_test_1.yml'),File.join(MYDIR,'yaml_test_2.yml')]
  actual=Dir[dirpath].sort
  assert_equal(expect,actual,"Dir[#{dirpath}] expects test data files")
 end

 def test_load_dir
  dirpath=File.join(MYDIR,'yaml_test_*.yml')
  expect=[
   "a:a1,a10,a2,a20,a3,a30;b:b1,b10,b2,b20,b3,b30;c:c1,c10,c2,c20,c3,c30", 
   "d:d1,d10,d2,d20,d3,d30;e:e1,e10,e2,e20,e3,e30;f:f1,f10,f2,f20,f3,f30", 
   "g:g1,g10,g2,g20,g3,g30;h:h1,h10,h2,h20,h3,h30;i:i1,i10,i2,i20,i3,i30",
   "j:j1,j10,j2,j20,j3,j30;k:k1,k10,k2,k20,k3,k30;l:l1,l10,l2,l20,l3,l30",
   "m:m1,m10,m2,m20,m3,m30;n:n1,n10,n2,n20,n3,n30;o:o1,o10,o2,o20,o3,o30", 
   "p:p1,p10,p2,p20,p3,p30;q:q1,q10,q2,q20,q3,q30;r:r1,r10,r2,r20,r3,r30", 
  ]
  actual=[]
  YAML.load_dir(dirpath){|doc| actual << doc.keys.map{|k| v=doc[k]; "#{k}:#{v.sort.join(",")}" }.sort.join(";") }
  actual.sort!
  assert_equal(expect,actual,'YAML.load_dir')
 end

end


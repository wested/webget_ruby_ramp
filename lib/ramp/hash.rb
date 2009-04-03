require 'yaml'

class Hash


  # Return true if size > 0
  def size?
    size>0
  end


  # Calls block once for each key in hsh,
  # passing the value as a parameter, 
  # and updating it in place.
  #
  #   h = { "a" => 100, "b" => 200 }
  #   h.each_value! {|value| value+5 }
  #   =>
  #   { "a" => 105, "b" => 205 }

  def each_value!
    each_pair{|key,value| self[key]=yield(value) }
    self
  end


  # Hash#to_yaml with sort 
  #
  # From http://snippets.dzone.com/tag/yaml

  def to_yaml_sort( opts = {} )
    YAML::quick_emit( object_id, opts ) do |out|
      out.map( taguri, to_yaml_style ) do |map|
        sort.each do |k, v|   # <-- here's my addition (the 'sort')
	  map.add( k, v )
        end
      end
    end
  end


  # Hash#rolldown aggregates value for a hash of hashes,
  # for example to help calculate subtotals grouped by key.
  #
  # Example:
  #   h={'a'=>{},'b'=>{},'c'=>{}}
  #   h['a']['x']=1
  #   h['a']['y']=2
  #   h['a']['z']=3
  #   h['b']['x']=4
  #   h['b']['y']=5
  #   h['b']['z']=6
  #   h['c']['x']=7
  #   h['c']['y']=8
  #   h['c']['z']=9
  #   h.rolldown => {"x"=>[1,4,7],"y"=>[2,5,8],"z"=>[3,6,9]}
  #
  # = Calculating subtotals
  #
  # The rolldown method is especially useful for calculating subtotals by key.
  #
  # Example:
  #   r=h.rolldown  
  #   r['x'].sum => 12
  #   r['y'].sum => 15
  #   r['z'].sum => 18
  #
  # = Block customization   
  #                                                                 
  # You can provide a block that will be called for the rolldown items.  
  #
  # Example:
  #   h.rolldown{|items| items.max } => {"a"=>7,"b"=>8,"c"=>9}
  #   h.rolldown{|items| items.join("-") } => {"a"=>"1-4-7","b"=>"2-5-8","c"=>"3-6-9"}
  #   h.rolldown{|items| items.inject{|sum,x| sum+=x } } => {"a"=>12,"b"=>15,"c"=>18}   

  def rolldown(&b)
    a=self.class.new
    each_pair{|k1,v1|
      v1.each_pair{|k2,v2|
        a[k2]=[] if (a[k2]==nil or a[k2]=={})
        a[k2]<<(v2)
      }
    }
    if block_given? 
      a.each_pair{|k,v| a[k]=(yield v)}
    end
    a
  end


  # Hash#rollup aggregates value for a hash of hashes,
  # for example to help calculate subtotals grouped by key.
  #
  # Example:
  #   h={'a'=>{},'b'=>{},'c'=>{}}
  #   h['a']['x']=1
  #   h['a']['y']=2
  #   h['a']['z']=3
  #   h['b']['x']=4
  #   h['b']['y']=5
  #   h['b']['z']=6
  #   h['c']['x']=7
  #   h['c']['y']=8
  #   h['c']['z']=9
  #   h.rollup => {"a"=>[1,2,3],"b"=>[4,5,6],"c"=>[7,8,9]} 
  #
  # = Calculating subtotals 
  #                                 
  # The rollup method is especially useful for calculating subtotals by key.  
  #
  # Example:
  #   r = h.rollup
  #   r['a'].sum => 6
  #   r['b'].sum => 15
  #   r['c'].sum => 24
  #
  # = Block customization
  #
  # You can provide a block that will be called for the rollup items.
  #
  # Example:
  #   h.rollup{|items| items.max } => {"a"=>3,"b"=>6,"c"=>9}
  #   h.rollup{|items| items.join("/") } => {"a"=>"1/2/3","b"=>"4/5/6","c"=>"7/8/9"}
  #   h.rollup{|items| items.inject{|sum,x| sum+=x } } => {"a"=>6,"b"=>15,"c"=>24}

  def rollup(&b)
    a=self.class.new
    each_pair{|k1,v1|
      v1.each_pair{|k2,v2|
        a[k1]=[] if (a[k1]==nil or a[k1]=={})
        a[k1]<<(v2)
      }
    }
    if block_given?
      a.each_pair{|k,v| a[k]=(yield v)}
    end
    a
  end

end

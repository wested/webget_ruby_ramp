require 'yaml'

class Hash


  # Return true if size > 0
  def size?
    size>0
  end


  # Calls block once for each key in hsh, passing the key and value to the block as a two-element array.
  # The keys are sorted.
  def each_sort
   keys.sort.each{|key| yield key,self[key] }
  end


  # Calls block once for each key in hsh, 
  # passing the key as a parameter,
  # and updating it in place.
  #
  #   h = { "a" => "b", "c" => "d" }
  #   h.each_key! {|key| key.upcase }
  #   h => { "A" => "b", "C" => "d" }
  #
  # Return self.

  def each_key!
    each_pair{|key,value|
      key2=yield(key)
      if key===key2
        #nop
      else
        self.delete(key)
        self[key2]=value
      end
    }
  end


  # Calls block once for each key in hsh,
  # passing the key and value as parameters,
  # and updated them in place.
  #
  #   h = { "a" => "b", "c" => "d" }
  #   h.each_pair! {|key,value| key.upcase, value.upcase }
  #   h => { "A" => "B", "C" => "D" }
  #
  # Return self.

  def each_pair!
    each_pair{|key,value|
      key2,value2=yield(key,value)
      if key===key2
        if value===value2
          #nop
        else
          self[key]=value2
        end
      else
        self.delete(key)
        self[key2]=value2
      end
    }
    return self
  end


  # Calls block once for each key in hsh,
  # passing the value as a parameter, 
  # and updating it in place.
  #
  #   h = { "a" => "b", "c" => "d" }
  #   h.each_value! {|value| value.upcase }
  #   h => { "a" => "B", "c" => "d" }
  #
  # Return self.

  def each_value!
    each_pair{|key,value| 
      value2=yield(value)
      if value===value2
        #nop
      else
        self[key]=yield(value) 
      end
    }
    return self
  end


  # Calls block once for each key-value pair in hsh,
  # passing the key and value as paramters to the block.
  #
  #   h = {"a"=>"b", "c"=>"d", "e"=>"f" }
  #   h.map_pair{|key,value| key+value }
  #   =>
  #   ["ab","cd","ef"]

  def map_pair
    keys.map{|key| yield key, self[key] }
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


  # Hash#pivot aggregates values for a hash of hashes,
  # for example to calculate subtotals and groups.
  #
  # Example:
  #   h={
  #    "a"=>{"x"=>1,"y"=>2,"z"=>3},
  #    "b"=>{"x"=>4,"y"=>5,"z"=>6},
  #    "c"=>{"x"=>7,"y"=>8,"z"=>9},
  #   }
  #   h.pivot(:keys) => {"a"=>[1,2,3],"b"=>[4,5,6],"c"=>[7,8,9]} 
  #   h.pivot(:vals) => {"x"=>[1,4,7],"y"=>[2,5,8],"z"=>[3,6,9]}
  #
  # = Calculating subtotals
  #
  # The pivot method is especially useful for calculating subtotals.
  #
  # ==Example
  #   r = h.pivot(:keys)
  #   r['a'].sum => 6
  #   r['b'].sum => 15
  #   r['c'].sum => 24
  #
  # ==Example
  #   r=h.pivot(:vals)
  #   r['x'].sum => 12
  #   r['y'].sum => 15
  #   r['z'].sum => 18
  #
  # = Block customization
  #
  # You can provide a block that will be called for the pivot items.
  #
  # ==Examples
  #   h.pivot(:keys){|items| items.max } => {"a"=>3,"b"=>6,"c"=>9}
  #   h.pivot(:keys){|items| items.join("/") } => {"a"=>"1/2/3","b"=>"4/5/6","c"=>"7/8/9"}
  #   h.pivot(:keys){|items| items.inject{|sum,x| sum+=x } } => {"a"=>6,"b"=>15,"c"=>24}
  #
  # ==Examples
  #   h.pivot(:vals){|items| items.max } => {"a"=>7,"b"=>8,"c"=>9}
  #   h.pivot(:vals){|items| items.join("-") } => {"a"=>"1-4-7","b"=>"2-5-8","c"=>"3-6-9"}
  #   h.pivot(:vals){|items| items.inject{|sum,x| sum+=x } } => {"a"=>12,"b"=>15,"c"=>18}   

  def pivot(direction='keys',&b)
    a=self.class.new
    direction=direction.to_s
    up=pivot_direction_up?(direction)
    each_pair{|k1,v1|
      v1.each_pair{|k2,v2|
        k = up ? k1 : k2
        a[k]=[] if (a[k]==nil or a[k]=={})
        a[k]<<(v2)
      }
    }
    if block_given? 
      a.each_pair{|k,v| a[k]=(yield v)}
    end
    a
  end

  protected

  def pivot_direction_up?(direction_name)
    case direction_name
    when 'key','keys','up','left','out' then return true
    when 'val','vals','down','right','in' then return false
    else raise 'Pivot direction must be either: up/left/out or down/right/in'
    end
  end

end

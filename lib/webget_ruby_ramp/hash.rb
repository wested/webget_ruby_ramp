# -*- encoding: utf-8 -*-

require 'yaml'

# Hash extensions

class Hash


  # @return [Boolean] true if size > 0

  def size?
    size>0
  end


  # Calls block once for each key in hsh, passing the key and value to the block as a two-element array.
  #
  # The keys are sorted.
  #
  # @example
  #   h = { "xyz" => "123", "abc" => "789" }
  #   h.each_sort {|key, val| ... }
  #   => calls the block with "abc" => "789", then with "xyz" => "123"

  def each_sort
    keys.sort.each{|key| yield key,self[key] }
  end


  # Calls block once for each key in hsh, 
  # passing the key as a parameter,
  # and updating it in place.
  #
  # @example
  #   h = { "a" => "b", "c" => "d" }
  #   h.each_key! {|key| key.upcase }
  #   h => { "A" => "b", "C" => "d" }
  #
  # @return self

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
    return self
  end



  # Calls block once for each key in hsh,
  # passing the key and value as parameters,
  # and updated them in place.
  #
  # @example
  #   h = { "a" => "b", "c" => "d" }
  #   h.each_pair! {|key,value| key.upcase, value.upcase }
  #   h => { "A" => "B", "C" => "D" }
  #
  # @return self.

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
  # @example
  #   h = { "a" => "b", "c" => "d" }
  #   h.each_value! {|value| value.upcase }
  #   h => { "a" => "B", "c" => "d" }
  #
  # @return self.

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
  # @example
  #   h = {"a"=>"b", "c"=>"d", "e"=>"f" }
  #   h.map_pair{|key,value| key+value }
  #   => ["ab","cd","ef"]

  def map_pair
    keys.map{|key| yield key, self[key] }
  end


  # Hash#to_yaml with sort 
  #
  # From http://snippets.dzone.com/tag/yaml
  #
  # @example
  #   h = {"a"=>"b", "c"=>"d", "e"=>"f" }
  #   h.to_yaml_sort
  #   => "--- \na: b\nc: d\ne: f\n"

  def to_yaml_sort( opts = {} )
    YAML::quick_emit( object_id, opts ) do |out|
      out.map( taguri, to_yaml_style ) do |map|
        sort.each do |key, val|   # <-- here's my addition (the 'sort')
	  map.add(key, val)
        end
      end
    end
  end


  # Hash#pivot aggregates values for a hash of hashes,
  # for example to calculate subtotals and groups.
  #
  # Suppose you have data arranged by companies, roles, and headcounts.
  #
  #     data = {
  #     "Apple"     => {"Accountants" => 11, "Designers" => 22, "Developers" => 33},
  #     "Goggle"    => {"Accountants" => 44, "Designers" => 55, "Developers" => 66},
  #     "Microsoft" => {"Accountants" => 77, "Designers" => 88, "Developers" => 99},
  #   }
  # 
  # To calculate each company's total headcount, you pivot up, then sum:
  # 
  #   data.pivot(:up,&:sum)
  #   => {
  #    "Apple"=>66, 
  #    "Goggle"=>165, 
  #    "Microsoft"=>264
  #   }
  # 
  # To calculate each role's total headcount, you pivot down, then sum:
  # 
  #   data.pivot(:down,&:sum)
  #   => {
  #    "Accountants"=>132,
  #    "Designers"=>165,
  #    "Developers"=>198
  #   }
  # 
  #  Generic xxample:
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
  # @example
  #   r = h.pivot(:keys)
  #   r['a'].sum => 6
  #   r['b'].sum => 15
  #   r['c'].sum => 24
  #
  # @example
  #   r=h.pivot(:vals)
  #   r['x'].sum => 12
  #   r['y'].sum => 15
  #   r['z'].sum => 18
  #
  # = Block customization
  #
  # You can provide a block that will be called for the pivot items.
  #
  # @example
  #   h.pivot(:keys){|items| items.max } => {"a"=>3,"b"=>6,"c"=>9}
  #   h.pivot(:keys){|items| items.join("/") } => {"a"=>"1/2/3","b"=>"4/5/6","c"=>"7/8/9"}
  #   h.pivot(:keys){|items| items.inject{|sum,x| sum+=x } } => {"a"=>6,"b"=>15,"c"=>24}
  #
  # @example
  #   h.pivot(:vals){|items| items.max } => {"a"=>7,"b"=>8,"c"=>9}
  #   h.pivot(:vals){|items| items.join("-") } => {"a"=>"1-4-7","b"=>"2-5-8","c"=>"3-6-9"}
  #   h.pivot(:vals){|items| items.inject{|sum,x| sum+=x } } => {"a"=>12,"b"=>15,"c"=>18}   

  def pivot(direction='keys',&block)
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
    if block
      a.each_pair{|key,val| a[key]=block.call(val)}
    end
    a
  end

  protected

  def pivot_direction_up?(direction_name)
    case direction_name.to_s
    when 'key','keys','up','left','out' then return true
    when 'val','vals','down','right','in' then return false
    else raise ArgumentError.new('Pivot direction must be either: key/keys/up/left/out or val/vals/down/right/in')
    end
  end

end

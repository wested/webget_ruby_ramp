require 'yaml'

module YAML

  # Load yaml documents from a directory
  #
  # ==Example
  #   YAML.load_dir('/tmp/*.yaml'){|yaml_document|
  #     #...whatever you want to do with each yaml document
  #   }
  #
  # ==Example to load documents in files ending in ".yaml" and ".yml"
  #   YAML.load_dir('/tmp/*.yaml','/tmp/*.yml','){|yaml_document|
  #     #...whatever you want to do with the yaml document
  #   }
  
  def YAML.load_dir(*dirpaths)
    dirpaths=[*dirpaths.flatten]
    dirpaths.each do |dirpath|
      Dir[dirpath].sort.each do |filename|
        File.open(filename) do |file|
          YAML.load_documents(file) do |doc|
            yield doc
          end #load
        end #file
      end #dir
    end #each
  end #def


  # Load yaml documents from a directory, and process the key/value pairs
  #
  # ==Example
  #   YAML.load_dir_pairs('/tmp/*.yaml'){|key,val|
  #     puts "This key is #{key}, val is #{val}"
  #   }
  #
  # This method wraps the YAML.load_dir method,
  # so if you choose to override YAML.load_dir 
  # then you'll automatically get the same kind
  # of behavior from YAML.load_dir_pairs.
  #
  # This method sorts the keys for you.

  def YAML.load_dir_pairs(*dirpaths)
    YAML.load_dir(dirpaths){|doc|
      doc.keys.sort.each{|key|
        yield key,doc[key]
      }
    }
  end


  # Map filepaths to their YAML.load equivalents.
  #
  # The filepaths can be strings or files, 
  # because this method will call File.open on strings.

  def YAML.load_files(*filepaths)
    filepaths.map{|filepath| 
      file = (filepath.is_a? File) ? filepath : File.open(filepath.to_s)
      YAML.load(file)
    }
  end


end

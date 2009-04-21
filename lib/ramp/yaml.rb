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

end

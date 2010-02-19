# -*- encoding: utf-8 -*-

require 'yaml'

# YAML extensions

module YAML

  # Specify one or more directory patterns and pass each YAML file in the matching directories to a block.
  #
  # See [Dir#glob](http://www.ruby-doc.org/core/classes/Dir.html#M002347) for pattern details.
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
      Dir[dirpath].each do |filename|
        File.open(filename) do |file|
          YAML.load_documents(file) do |doc|
            yield doc
          end #load
        end #file
      end #dir
    end #each
  end #def

end

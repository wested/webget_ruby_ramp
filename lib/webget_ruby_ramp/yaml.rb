# -*- encoding: utf-8 -*-

require 'yaml'

# YAML extensions

module YAML


  # Specify one or more directory patterns and pass each YAML file in the matching directories to a block.
  #
  # @see [Dir#glob](http://www.ruby-doc.org/core/classes/Dir.html#M002347) for pattern details.
  #
  # @example To load documents in files ending in ".yaml"
  #   YAML.load_dir('/tmp/*.yaml'){|yaml_document|
  #     #...whatever you want to do with each yaml document
  #   }
  #
  # @example To load documents in files beginning in "foo" or "bar"
  #   YAML.load_dir('/tmp/foo*.yaml','/tmp/bar*.yaml','){|yaml_document|
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

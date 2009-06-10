require 'rexml/document'

module XML

  # Load xml documents from a directory
  #
  # ==Example
  #   XML.load_dir('/tmp/*.xml'){|xml_document|
  #     #...whatever you want to do with each xml document
  #   }
  #
  # ==Example to load xml documents in files beginning in "foo" or "bar"
  #   XML.load_dir('/tmp/foo*.yaml','/tmp/bar*.xml','){|yaml_document|
  #     #...whatever you want to do with the yaml document
  #   }

  def XML.load_dir(*dirpaths)
    dirpaths=[*dirpaths.flatten]
    dirpaths.each do |dirpath|
      Dir[dirpath].sort.each do |filename|
        File.open(filename) do |file|
          doc = REXML::Document.new file
          yield doc
        end #file
      end #dir
    end #each
  end #def                                                                                                                                                                                                                          
end


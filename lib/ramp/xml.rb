require 'rexml/document' 

module XML

  # Specify one or more directory patterns and pass each XML file in the matching directories to a block; 
  # see [Dir#glob](http://www.ruby-doc.org/core/classes/Dir.html#M002347) for pattern details.
  #
  # ==Example
  #   XML.load_dir('/tmp/*.xml'){|xml_document|
  #     #...whatever you want to do with each xml document
  #   }
  #
  # ==Example to load xml documents in files beginning in "foo" or "bar"
  #   XML.load_dir('/tmp/foo*.yaml','/tmp/bar*.xml','){|xml_document|
  #     #...whatever you want to do with the xml document
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


  # Sugar to load elements from a file.
  #
  # ==Example
  #   XML.load_attributes('config.xml','userlist/user'){|element| pp element.attributes['first_name'] }

  def XML.load_elements(dirpath,xpath)
    XML.load_dir(dirpath){|doc|
      doc.elements.each(xpath){|e|
        yield e
      }
    }
  end


  # Sugar to load attributes from a file to a hash.
  #
  # ==Example
  #   XML.load_attributes('config.xml','userlist/user'){|attributes| pp attributes['first_name'] }

  def XML.load_attributes(dirpath,xpath)
    XML.load_elements(dirpath,xpath){|e|
      yield e.attributes
    }
  end

end


class REXML::Attributes

  def hash
    h=Hash.new
    self.keys.each{|k| h[k]=self[k]}
    h
  end

end




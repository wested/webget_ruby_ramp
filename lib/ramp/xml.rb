require 'rexml/document' 

module XML


  # Specify one or more directory patterns and pass each XML file in the matching directories to a block.
  #
  # See [Dir#glob](http://www.ruby-doc.org/core/classes/Dir.html#M002347) for pattern details.
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


  # Sugar to load attributes from a file.
  #
  # ==Example
  #   XML.load_attributes('config.xml','userlist/user'){|attributes| pp attributes['first_name'] }

  def XML.load_attributes(dirpath,xpath)
    XML.load_elements(dirpath,xpath){|e|
      yield e.attributes
    }
  end

  # Sugar to load attributes hash from a file.
  #
  # ==Example
  #   XML.load_attributes('config.xml','userlist/user'){|attributes| pp attributes['first_name'] }

  def XML.load_attributes_hash(dirpath,xpath)
    XML.load_elements(dirpath,xpath){|e|
      yield e.attributes.to_hash
    }
  end

end


class REXML::Attributes

  # Return a new hash of the attribute keys and values.
  #
  # ==Example
  #   attributes.to_hash => {"src"=>"pic.jpg", "height" => "100", "width" => "200"} 

  def to_hash
    h=Hash.new
    self.keys.each{|k| h[k]=self[k]}
    h
  end

end


class REXML::Document

  # Remove all attributes from the document's elements.
  #
  # cf. Element#remove_attributes

  def remove_attributes
    self.elements.each("//") { |e| e.attributes.each_attribute{|attribute| attribute.remove }}
  end
  
end


class REXML::Element

  # Remove all attributes from the element.
  # cf. Document#remove_attributes

  def remove_attributes
    self.attributes.each_attribute{|attribute| attribute.remove }
  end

end




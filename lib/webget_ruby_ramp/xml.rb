# -*- encoding: utf-8 -*-

require 'rexml/document' 

# XML extensions

module XML


  # Specify one or more directory patterns and pass each XML file in the matching directories to a block.
  #
  # See [Dir#glob](http://www.ruby-doc.org/core/classes/Dir.html#M002347) for pattern details.
  #
  # @example To load xml documents
  #   XML.load_dir('/tmp/*.xml'){|xml_document|
  #     #...whatever you want to do with each xml document
  #   }
  #
  # @example To load xml documents in files beginning in "foo" or "bar"
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
  # @example
  #   XML.load_attributes('config.xml','userlist/user'){|element| pp element.attributes['first_name'] }

  def XML.load_elements(dirpath,xpath)
    XML.load_dir(dirpath){|doc|
      doc.elements.each(xpath){|elem|
        yield elem
      }
    }
  end


  # Sugar to load attributes from a file.
  #
  # @example
  #   XML.load_attributes('config.xml','userlist/user'){|attributes| pp attributes['first_name'] }

  def XML.load_attributes(dirpath,xpath)
    XML.load_elements(dirpath,xpath){|elem|
      yield elem.attributes
    }
  end

  # Sugar to load attributes hash from a file.
  #
  # @example
  #   XML.load_attributes('config.xml','userlist/user'){|attributes| pp attributes['first_name'] }

  def XML.load_attributes_hash(dirpath,xpath)
    XML.load_elements(dirpath,xpath){|elem|
      yield elem.attributes.to_hash
    }
  end


  # Santize dirty xml by removing unprintables, bad tags,
  # comments, and generally anything else we might need
  # to enable the XML parser to handle a dirty document.
  #
  # This method calls these in order:
  #   - XML.strip_unprintables
  #   - XML.strip_microsoft
  #   - XML.strip_comments
  #   - XML.strip_attributes
  #
  # @example 
  #   # This example shows curly braces instead of angle braces because of HTML formatting
  #   s="{foo a=b c=d}{!--comment--}Hello{!-[if bar]}Microsoft{![endif]}World{/foo}"
  #   XML.strip_all(s) => "{foo}HelloWorld{/foo}"
  #
  # @return [String] the text, stripped of unprintables, Microsoft markup, comments, and attributes

  def XML.strip_all(xml_text)
    return XML.strip_attributes(XML.strip_comments(XML.strip_microsoft(XML.strip_unprintables(xml_text))))
  end


  # Strip out all attributes from the xml text's tags.
  #
  # @example
  #   s="<foo a=b c=d e=f>Hello</foo>"
  #   XML.strip_attributes(s) => "<foo>Hello</foo>"
  #
  # @return [String] the text, stripped of attributes

  def XML.strip_attributes(xml_text)
    return xml_text.gsub(/<(\/?\w+).*?>/im){"<#{$1}>"}  # delete attributes
  end


  # Strip out all comments from the xml text.
  #
  # @example
  #   # This example shows curly braces instead of angle braces because of HTML formatting
  #   s="Hello{!--comment--}World"
  #   XML.strip_comments(s) => "HelloWorld"
  #
  # @return [String] the text, stripped of comments

  def XML.strip_comments(xml_text)
    return xml_text.gsub(/<!.*?>/im,'')  
  end


  # Strip out all microsoft proprietary codes.
  #
  # @example
  #   s="Hello<!-[if foo]>Microsoft<![endif]->World"
  #   XML.strip_microsoft(s) => "HelloWorld"
  #
  # @return [String] the text, stripped of Microsoft markup

  def XML.strip_microsoft(xml_text)
    return xml_text.gsub(/<!-*\[if\b.*?<!\[endif\]-*>/im,'')
  end


  # Strip out all unprintable characters from the input string.
  #
  # @example
  #   s="Hello\XXXWorld" # where XXX is unprintable
  #   XML.strip_unprintables(s) => "HelloWorld"
  #
  # @return [String] the text, stripped of unprintables

  def XML.strip_unprintables(xml_text)
    return xml_text.gsub(/[^[:print:]]/, "")
  end

end


# REXML::Attributes extensions

class REXML::Attributes

  # @return a new hash of the attribute keys and values.
  #
  # @example
  #   attributes.to_hash => {"src"=>"pic.jpg", "height" => "100", "width" => "200"} 

  def to_hash
    h=Hash.new
    self.keys.each{|k| h[k]=self[k]}
    h
  end

end


# REXML::Document extensions

class REXML::Document

  # Remove all attributes from the document's elements.
  # 
  # @return the document.
  #
  # @see Element#remove_attributes

  def remove_attributes
    self.elements.each("//") { |elem| elem.attributes.each_attribute{|attribute| attribute.remove }}
    self
  end
  
end


# REXML::Element extensions

class REXML::Element

  # Remove all attributes from the element.
  #
  # @return the element.
  #
  # @see Document#remove_attributes

  def remove_attributes
    self.attributes.each_attribute{|attribute| attribute.remove }
    self
  end

end




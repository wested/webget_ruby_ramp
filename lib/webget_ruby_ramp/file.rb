class File

  # Return File.join(File.dirname(dirname),strings)
  #
  # ==Example
  #   File.joindir(__FILE__,'foo.txt')
  #   => '/home/john/foo.txt'

  def File.joindir(dirname,*strings)
    File.join(File.dirname(dirname),strings)
  end

end

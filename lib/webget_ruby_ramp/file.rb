# -*- encoding: utf-8 -*-

# File extensions

class File

  # @return [String] File.join(File.dirname(dirname),strings)
  #
  # @example
  #   File.joindir(__FILE__,'foo.txt')
  #   => '/home/john/foo.txt'

  def File.joindir(dirname,*strings)
    File.join(File.dirname(dirname),strings)
  end

end

class IO

  # Reads the entire file specified by name as individual lines as with IO#readlines,
  # and returns those lines in an array of rows, where each row is an array of fields.
  #
  # - Lines are separated by _sep_string_, which defaults to $/ or "\n" 
  # - Rows are split by _split_, which defaults to $; or /\t/
  #
  # See:
  # - File#readline
  # - File#readlines
  # - File#readrow

  def IO.readrows(name, sep_string=$/, split=$;)
    sep_string||="\n"
    split||=/\t/
    return IO.readlines(name, sep_string).map{|line| line.chomp(sep_string).split(split)}
  end

  # Read a line as with IO#readline and return the line as a row of fields.
  #
  # - Lines are separated by _sep_string_, which defaults to $/ or "\n" 
  # - Rows are split by _split_, which defaults to $; or /\t/
  #
  # See:
  # - File#readline
  # - File#readlines
  # - File#readrows

  def readrow(sep_string=$/,split=$;)
    sep_string||="\n"
    split||=/\t/
    return readline(sep_string).chomp(sep_string).split(split)
  end

end

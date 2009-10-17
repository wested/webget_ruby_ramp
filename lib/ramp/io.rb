class IO


  # Reads the entire file specified by name as individual lines as with IO#readlines,
  # and returns those lines in an array of rows, where each row is an array of fields.
  #
  # ==Example
  #   IO.readrows("my.tsv")
  #    => [["A1","B1","C1"],["A2","B2","C2"],["A3","B3","C3"]]
  #
  # ==Options
  # - Rows are separated by _row_ option, which defaults to Ruby's record separator $/ or "\n" 
  # - Cols are separated by _col_ option, which defaults to Ruby's string split separator $; or "\t"
  #
  # ==Example with options suitable for a file using TSV (Tab Separated Values)
  #   IO.readrows("my.tsv", :row=>"\n", :col=>"\t") 
  #
  # Note: the col option is sent along to String#split, so can be a string or a regexp.
  #
  # See:
  # - File#readline
  # - File#readlines
  # - File#readrow

  def IO.readrows(name, options={})
    row_sep||=options['row']||$/||"\n"
    col_sep||=options['col']||$;||"\t"
    return IO.readlines(name, row_sep).map{|line| line.chomp(row_sep).split(col_sep)}
  end


  # Read a line as with IO#readline and return the line as a row of fields.
  #
  # ==Example
  #   file = File.new("my.tsv")
  #   file.readrow() => ["A1","B1","C1"]
  #   file.readrow() => ["A2","B2","C2"]
  #   file.readrow() => ["A3","B3","C3"]]
  #
  # ==Options
  # - Rows are separated by _row_ option, which defaults to Ruby's record separator $/ or "\n" 
  # - Cols are separated by _col_ option, which defaults to Ruby's string split separator $; or "\t"
  #
  # ==Example with options suitable for a file using TSV (Tab Separated Values)
  #   file = File.new("my.tsv")
  #   file.readrow(:row=>"\n", :col=>"\t") => ["A1","B1","C1"] 
  #   file.readrow(:row=>"\n", :col=>"\t") => ["A2","B2","C2"] 
  #   file.readrow(:row=>"\n", :col=>"\t") => ["A3","B3","C3"] 
  #
  # Note: the col option is sent along to String#split, so can be a string or a regexp.
  #
  # See:
  # - File#readline
  # - File#readlines
  # - File#readrows

  def readrow(options={})
    row_sep||=options['row']||$/||"\n"
    col_sep||=options['col']||$;||"\t"
   return readline(row_sep).chomp(row_sep).split(col_sep)
  end

end

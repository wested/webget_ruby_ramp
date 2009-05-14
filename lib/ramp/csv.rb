
class CSV

  # Return HTTP headers for a CSV file download.
  #
  # Options
  #   - filename: default is "data.csv"
  #   - request: the incoming http request, which is used to return MSIE-specific headers
  #
  # Example
  #   headers = CSV.http_headers("myfile.csv")
  #
  # From http://stackoverflow.com/questions/94502/in-rails-how-to-return-records-as-a-csv-file/94520
  
  def self.http_headers(ops={})
    filename=ops[:filename]||'data.csv'
    request=ops[:request]||nil
    headers={}
    if request
      if request.env['HTTP_USER_AGENT'] =~ /msie/i
        headers['Pragma'] = 'public'
        headers['Content-Type'] = "text/plain" 
        headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
        headers['Expires'] = "0" 
      end
    else
      headers['Content-Type'] = "text/csv" 
    end
    headers['Content-Disposition'] = "attachment; filename=\"#{filename}\"" 
    return headers
  end
  
end


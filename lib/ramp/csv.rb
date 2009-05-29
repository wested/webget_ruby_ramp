
class CSV

  # Return HTTP headers for a typical CSV file download without caching.
  #
  # Options
  #   - filename: default is "data.csv"
  #   - request: the incoming http request, which is used to return MSIE-specific headers
  #
  # Example
  #   headers = CSV.http_headers("myfile.csv")
  #
  # Example for Rails
  #   response.headers.merge CSV.http_headers("myfile.csv")
  # 
  # Ideas from http://stackoverflow.com/questions/94502/in-rails-how-to-return-records-as-a-csv-file/94520
  
  def self.http_headers(ops={})
    filename=ops[:filename]||'data.csv'
    request=ops[:request]||nil
    msie = (request and request.env['HTTP_USER_AGENT'] =~ /msie/i)
    return {
     'Content-Type' => msie ? 'text/plain' : 'text/csv'
     'Cache-Control' => 'no-cache, must-revalidate, post-check=0, pre-check=0'
     'Expires' => "0",
     'Pragma' => 'no-cache',
     'Content-Disposition' => "attachment; filename=\"#{filename}\"",
    }
  end
  
end


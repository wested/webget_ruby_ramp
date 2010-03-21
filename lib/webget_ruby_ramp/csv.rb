# -*- encoding: utf-8 -*-

# Comma Separated Values extensions

class CSV

  # @return [Hash<String,String>] HTTP headers for a typical CSV file download without caching.
  #
  # ==Options
  #   - filename: defaults to "data.csv"
  #   - request: the incoming http request, which is used to return MSIE-specific headers
  #
  # @example
  #   headers = CSV.http_headers("myfile.csv")
  #
  # @example for Rails
  #   response.headers.merge CSV.http_headers("myfile.csv")
  # 
  # Ideas from http://stackoverflow.com/questions/94502/in-rails-how-to-return-records-as-a-csv-file/94520
  
  def self.http_headers(options={})
    filename = options[:filename] || 'data.csv'
    options=self.http_headers_adjust_for_broken_msie(options)
    content_type = options[:content_type] || 'text/csv'
    return options[:cache] \
    ? {
       'Content-Type' => content_type,
       'Content-Disposition' => "attachment; filename=\"#{filename}\"",
      } \
    : {
       'Content-Type' => content_type,
       'Cache-Control' => 'no-cache, must-revalidate, post-check=0, pre-check=0',
       'Expires' => "0",
       'Pragma' => 'no-cache',
       'Content-Disposition' => "attachment; filename=\"#{filename}\"",
      }
    end


  # Helper to try to "do the right thing" for the common case of Rails & MS IE.
  #
  # Rails automatically defines a _request_ object,
  # that has an env HTTP_USER_AGENT.
  # 
  # @return [Hash<String,String>] HTTP headers

  def self.http_headers_adjust_for_broken_msie(options={})
    request = options[:request] || request 
    msie = (request and request.env['HTTP_USER_AGENT'] =~ /msie/i)
    if msie
      options[:content_type]||='text/plain'
      options[:cache]||=false
    end
    return options
  end

end


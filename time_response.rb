class TimeResponse
  
  REQUEST_FORMAT = { "year" => '%Y-',
                     "month" => '%m-',
                     "day" => '%d ',
                     "hour" => '%H:',
                     "minute" => '%M:',
                     "second" => '%S' }

  def initialize(query)
    @request = Rack::Utils.parse_nested_query(query).values.join.split(',')
  end

  def time
    time_format = (@request.map{ |value| REQUEST_FORMAT[value] }).join('')
    DateTime.now.strftime(time_format)
  end  

  def request_valid?
    (@request - REQUEST_FORMAT.keys).empty?
  end
  
  def status
    request_valid? ? 200 : 400
  end

  def body
    request_valid? ? time : 'Request is not valid'
  end  
  
end
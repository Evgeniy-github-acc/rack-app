class App

  def call(env)
    accept_path?(env["REQUEST_PATH"]) ? time_response(env["QUERY_STRING"]) : response(404, "Path doesn't exist")
  end

  def time_response(query)
    time_response = TimeResponse.new(query)
    
    response(time_response.status, time_response.body)
  end

  def accept_path?(path)
    path == "/time"
  end

  def response(status, body)
    Rack::Response.new(body, status, { 'Content-Type' => 'text/plain' }).finish
  end

end
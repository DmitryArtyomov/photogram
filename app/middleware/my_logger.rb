class MyLogger
  def initialize(app)
    @app = app
  end

  def call env
    dup._call env
  end

  def _call(env)
    request_started_on = Time.now
    @status, @headers, @response = @app.call(env)
    request_ended_on = Time.now

    write_to_log("Request took #{request_ended_on - request_started_on} seconds.")

    [@status, @headers, @response]
  end

  private

  def write_to_log(text)
    log_text = "[#{Time.now.strftime('%F %T')}]: #{text}\n"
    File.write('log/requests.log', log_text, mode: 'a')
  end
end

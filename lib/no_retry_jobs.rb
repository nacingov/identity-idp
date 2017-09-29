class NoRetryJobs
  def call(_worker, msg, _queue)
    yield
  rescue StandardError => _e
    msg['retry'] = false
    raise
  end
end

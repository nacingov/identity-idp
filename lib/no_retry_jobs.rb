class NoRetryJobs
  def call(_worker, msg, queue)
    yield
  rescue StandardError => _e
    return unless queue == 'idv'
    msg['retry'] = false
    raise
  end
end

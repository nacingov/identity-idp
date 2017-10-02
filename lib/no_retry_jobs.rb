class NoRetryJobs
  def call(_worker, msg, queue)
    return unless queue == 'idv'
    yield
  rescue StandardError => _e
    msg['retry'] = false
    raise
  end
end

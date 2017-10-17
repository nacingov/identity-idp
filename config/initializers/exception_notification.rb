require 'exception_notification/rails'
require 'exception_notification/sidekiq'

EXCEPTION_RECIPIENTS = JSON.parse(Figaro.env.exception_recipients).freeze

ExceptionNotification.configure do |config|
  config.add_notifier(
    :email,
    email_prefix: "[#{APP_NAME} EXCEPTION - #{Figaro.env.domain_name}] ",
    sender_address: %("Exception Notifier" <notifier@login.gov>),
    exception_recipients: EXCEPTION_RECIPIENTS,
    error_grouping: true
  )
end

class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@#{ENV['PRODUCTION_HOST'] || 'photogram.net'}"
  layout 'mailer'
end

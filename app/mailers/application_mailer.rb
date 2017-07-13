class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@#{ENV['production_host'] || 'photogram.net'}"
  layout 'mailer'
end

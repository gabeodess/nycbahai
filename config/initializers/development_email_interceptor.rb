class DevelopmentEmailInterceptor
  def self.delivering_email(message)
    email = 'gabeodess@gmail.com'
    # Rails.logger.debug "Changing #{message.to} to #{email}"
    # message.to = [email]
  end
end

if Rails.env.development?
  ActionMailer::Base.register_interceptor(DevelopmentEmailInterceptor)
end

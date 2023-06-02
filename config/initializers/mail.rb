Mail.defaults do
    delivery_method :smtp, {
      address: 'smtp.gmail.com',
      port: 587,
      domain: 'gmail.com',
      user_name: 'aeucampos@gmail.com',
      password: Rails.application.credentials.gmail[:password],
      authentication: 'plain',
      enable_starttls_auto: true
    }
end
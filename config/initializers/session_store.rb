Rails.application.config.session_store(
  :redis_store,
  servers: [
    {
      url: ENV.fetch('REDIS_URL') { 'redis://localhost:6379/0/session' },
      namespace: 'session',
    }
  ],
  expire_after: 1.day,
  key: "_#{Rails.application.class.parent_name.downcase}_session",
  secure: Rails.env.production?,
  httponly: true,
)

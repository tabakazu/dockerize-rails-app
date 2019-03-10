threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

# port ENV.fetch("PORT") { 3000 }
bind ENV.fetch("RAILS_SOCKET") { "unix://#{Rails.root}/tmp/sockets/puma.sock" }

environment ENV.fetch("RAILS_ENV") { "development" }

plugin :tmp_restart

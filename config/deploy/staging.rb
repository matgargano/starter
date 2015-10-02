set :stage, :staging
set :deploy_to, -> { "/var/www/#{fetch(:application)}" }
set :dir, "/var/www/#{fetch(:application)}/current/web"
server '{{SERVER}}', user: 'www-data', roles: %w{web app db}


fetch(:default_env).merge!(wp_env: :staging)
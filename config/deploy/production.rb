set :stage, :staging
set :deploy_to, -> { "/home/ubuntu/#{fetch(:application)}/public" }
set :dir, "/home/ubuntu/#{fetch(:application)}/public/current/web/"

server '{{SERVER}}', user: 'ubuntu', roles: %w{web app db}


fetch(:default_env).merge!(wp_env: :staging)
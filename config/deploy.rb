# config valid only for current version of Capistrano
lock '3.4.0'

set :application, '{{LOCATION}}'
set :repo_url, '{{REPO}}'
set :log_level, :info
set :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :linked_files, fetch(:linked_files, []).push('.env')
set :linked_dirs, fetch(:linked_dirs, []).push('web/uploads')



namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app) do
    	within release_path do
	      
	      execute :composer, :install
        execute :npm, :install
        execute :bower, :install
        execute :grunt
	      


	  end
    end
  end
end

after 'deploy:publishing', 'deploy:restart'

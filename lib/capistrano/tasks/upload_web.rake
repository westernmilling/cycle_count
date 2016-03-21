namespace :deploy do
  task :upload_web do
    application_name = fetch(:application_name)
    deploy_public_to = fetch(:deploy_public_to)
    web_servers = fetch(:web_servers)
    web_servers.each do |web_server|
      puts "Deploying to web server: #{web_server}"
      puts "\trsync to: #{deploy_public_to}/#{application_name}"
      run_locally do
        execute :ssh,
                "www@#{web_server}",
                "mkdir -p #{deploy_public_to}/#{application_name}"
        execute :rsync,
                '-av ./public ' \
                "www@#{web_server}:#{deploy_public_to}/#{application_name}"
      end
    end
  end
end

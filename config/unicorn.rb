root = File.expand_path('../../', __FILE__)
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"

listen 3000

if ENV['RAILS_ENV'] == 'development'
  worker_processes 1
else
  stderr_path "#{root}/log/unicorn.log"
  stdout_path "#{root}/log/unicorn.log"

  worker_processes 2
end
timeout 30

before_exec do |_|
  ENV['BUNDLE_GEMFILE'] = File.join(root, 'Gemfile')
end

preload_app true

before_fork do |server, worker|
  server.logger.info("worker=#{worker.nr} spawning in #{Dir.pwd}")

  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!

  old_pid = "#{root}/tmp/pids/unicorn.pid.oldbin"
  if File.exist?(old_pid) && server.pid != old_pid
    begin
      Process.kill('QUIT', File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |_server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection

  begin
    uid = Process.euid
    gid = Process.euid
    user = 'deploy'
    group = 'deploy'
    target_uid = Etc.getpwnam(user).uid
    target_gid = Etc.getgrnam(group).gid
    worker.tmp.chown(target_uid, target_gid)
    if uid != target_uid || gid != target_gid
      Process.initgroups(user, target_gid)
      Process::GID.change_privilege(target_gid)
      Process::UID.change_privilege(target_uid)
    end
  rescue => e
    if %{development staging}.include?(Rails.env)
      STDERR.puts "couldn't change user, oh well"
    else
      raise e
    end
  end
end

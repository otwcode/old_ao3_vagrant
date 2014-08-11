# This file is under svn and cfengine control
# Edits will disappear if not done correctly

rails_env = ENV['RAILS_ENV'] || 'development'  

listen "0.0.0.0:7082", :backlog => 4096
#Really only for monitoring

worker_processes 2
timeout 120

pid "/tmp/unicorn.pid"
stderr_path "log/unicorn_err.log"
stdout_path "log/unicorn_out.log"

preload_app false

before_fork do |server, worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!

  # # This allows a new master process to incrementally
  # # phase out the old master process with SIGTTOU to avoid a
  # # thundering herd (especially in the "preload_app false" case)
  # # when doing a transparent upgrade.  The last worker spawned
  # # will then kill off the old master process with a SIGQUIT.
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end


  # throttle the master from forking too quickly by sleeping
  sleep 1
end

after_fork do |server, worker|
  # the following is *required* for Rails + "preload_app true",
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end


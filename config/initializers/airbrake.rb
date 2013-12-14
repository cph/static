Airbrake.configure do |config|
  config.api_key          = '5c39f80f41326474124612d5de4f0575'
  config.host             = 'errbit.cphepdev.com'
  config.port             = 80
  config.secure           = config.port == 443
  config.user_attributes  = %w{id email} # the default is just 'id'
  config.async            = true # requires the gem 'sucker_punch'
end


# Inform Errbit of the version of the codebase checked out

GIT_COMMIT = ENV.fetch('COMMIT_HASH', `git log -n1 --format='%H'`.chomp).freeze

module SendCommitWithNotice
  def cgi_data
    super.merge("GIT_COMMIT" => GIT_COMMIT)
  end
end

Airbrake::Notice.send :prepend, SendCommitWithNotice

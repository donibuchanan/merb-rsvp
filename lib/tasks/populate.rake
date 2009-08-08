desc "Populate with one user"
  task :populate => :merb_env do
    u = User.new(login: 'don')
    u.password = u.password_confirmation = 'don'
    u.save
    %w{don nicole}.each do |name|
      u.invites.create(name: name)
    end
  end


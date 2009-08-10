desc "Populate with one user"
  task :populate => :merb_env do
    unless u = User.first(login: 'don')
      u = User.new(login: 'don')
      u.password_plain = u.password = u.password_confirmation = 'don'
      u.email = "mail@donaldbuchanan.com"
      u.save
      %w{don nicole}.each do |name|
        u.invites.create(name: name)
      end
    end
    if u.submissions.blank?
      u.submissions.create(content: 'Pubic moustaches are the way forward.')
      u.submissions.create(content: 'The snowball is only a stepping stone to the fireball.')

      u.submissions.create(type: :video, content: 'http://www.youtube.com/watch?v=RBnLZH7Aqj0&eurl=http://192.168.56.101:4000/don&feature=player_embedded')
      u.submissions.create(type: :video, content: 'http://www.youtube.com/watch?v=Ij-AQIw4bl8&feature=related')
    end
  end


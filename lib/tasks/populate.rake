desc "Populate with one user"
  task :populate => :merb_env do
  
    reader = File.open('config/initial_data.txt', 'r')
    # skip first line
    lines = 0
    reader.lines.to_a[1..-1].each do |line|
      lines += 1
      puts line
      parts = line.split("\t")
      u = User.new(
        type: parts[0],
        login: parts[3]
      )
      u.password_plain = u.password = u.password_confirmation = parts[1]
      u.email = parts[6]
      u.save!
      if parts[4]
        u.invites.create(name: parts[4])
      end
      if parts[5]
        u.invites.create(name: parts[5])
      end

    end
  
    unless u = User.first(login: 'don')
      u = User.new(login: 'don')
      u.password_plain = u.password = u.password_confirmation = 'don'
      u.email = "mail@donaldbuchanan.com"
      u.save
      %w{don nicole}.each do |name|
        u.invites.create(name: name)
      end
    end
    
    puts "#{User.count} users created from #{lines} lines"
    if u.submissions.blank?
      u.submissions.create(content: 'Pubic moustaches are the way forward.')
      u.submissions.create(content: 'The snowball is only a stepping stone to the fireball.')

      u.submissions.create(type: :video, content: 'http://www.youtube.com/watch?v=RBnLZH7Aqj0&eurl=http://192.168.56.101:4000/don&feature=player_embedded')
      u.submissions.create(type: :video, content: 'http://www.youtube.com/watch?v=Ij-AQIw4bl8&feature=related')
    end
  end


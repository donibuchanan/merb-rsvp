 begin
      $TESTING = true # workaround a conflict between DataMapper and Vlad
      require "vlad"
      Vlad.load(:app => :thin, :scm => "git")
    rescue LoadError
      # do nothing
    end


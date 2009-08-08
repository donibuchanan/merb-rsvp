class Invites < Application
  # provides :xml, :yaml, :js
  provides :json
  def index
    @invites = session.user.invites
    display @invites
  end

  def show(id)
    @invite = Invite.get(id)
    raise NotFound unless @invite
    display @invite
  end
  
  def new
    only_provides :html
    @invite = Invite.new
    display @invite
  end

  def edit(id)
    only_provides :html
    @invite = Invite.get(id)
    raise NotFound unless @invite
    display @invite
  end

  def create(invite)
    @invite = Invite.new(invite)
    if @invite.save
      redirect resource(@invite), :message => {:notice => "Invite was successfully created"}
    else
      message[:error] = "Invite failed to be created"
      render :new
    end
  end

  def update(id, invite)
    
    @invite = Invite.get(id)
    raise NotFound unless @invite
    puts "asdf"
    if @invite.update_attributes(invite)
      puts "222"
      case content_type
        when :json
          display @invite
        else
          redirect resource(@invite)
      end       
    else
    puts @invite.errors.inspect
      display @invite, :edit
    end
  end

  def destroy(id)
    @invite = Invite.get(id)
    raise NotFound unless @invite
    if @invite.destroy
      redirect resource(:invites)
    else
      raise InternalServerError
    end
  end

end # Invites

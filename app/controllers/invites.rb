class Invites < Application
  # provides :xml, :yaml, :js
  provides :json
  def index(login_name)
    if !login_name.blank? && login_name != session.user.login
      session.abandon!
      redirect "/#{login_name}"
    else
      @invites = session.user.invites
      display @invites
    end
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
    if @invite.update_attributes(invite)
      case content_type
        when :json
          display @invite
        else
          redirect resource(@invite)
      end       
    else
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

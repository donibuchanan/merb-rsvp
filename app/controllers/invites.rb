class Invites < Application
  # provides :xml, :yaml, :js

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
    if @invite.update_attributes(invite)
       redirect resource(@invite)
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

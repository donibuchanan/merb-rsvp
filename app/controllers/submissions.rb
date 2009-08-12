 class Submissions < Application
  # provides :xml, :yaml, :js

  def index
    @submissions = Submission.all
    display @submissions
  end

  def show(id)
    @submission = Submission.get(id)
    raise NotFound unless @submission
    display @submission
  end
  
  def current_type
    params[:type] ||= "text"
  end
  def last_viewed_key
    "last_viewed#{current_type}"
  end
  
  def show_random
    headers['cache-control'] = "no-store, no-cache, must-revalidate"
    headers['expires'] = "Sat, 26 Jul 1997 05:00:00 GMT"
    provides :json
    last_viewed = (session[last_viewed_key] ||= -1)
    
    last_viewed += 1
    if last_viewed >= Submission.count(:type=>current_type.to_sym)
      last_viewed = 0
    end
    session[last_viewed_key] = last_viewed
    @submission = Submission.all(:type=>current_type.to_sym)[last_viewed]
    raise NotFound unless @submission
    display @submission
  end

  def new
    only_provides :html
    @submission = Submission.new
    display @submission
  end

  def edit(id)
    only_provides :html
    @submission = Submission.get(id)
    raise NotFound unless @submission
    display @submission
  end

  def create(submission)
    provides :json
    @submission = Submission.new(submission)
    @submission.user = session.user
    if @submission.save
      case content_type
        when :json
          display @submission
        else
          redirect resource(@submission), :message => {:notice => "Submission was successfully created"}
      end      
    else
      message[:error] = @submission.errors.first
      case content_type
        when :json
          message.to_json
        else
          render :new
      end
    end
  end

  def update(id, submission)
    @submission = Submission.get(id)
    raise NotFound unless @submission
    if @submission.update_attributes(submission)
       redirect resource(@submission)
    else
      display @submission, :edit
    end
  end

  def destroy(id)
    @submission = Submission.get(id)
    raise NotFound unless @submission
    if @submission.destroy
      redirect resource(:submissions)
    else
      raise InternalServerError
    end
  end

end # Submissions

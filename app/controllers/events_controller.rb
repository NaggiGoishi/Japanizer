class EventsController < ApplicationController

  include UserStatus

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    redirect_to user_path(current_user.id)
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @theuser = current_user
    @theevent = find_event(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id

    if @event.save
      redirect_to user_path(current_user), notice: 'Event was successfully created.'
    else
      @theuser = current_user
      @posts = @theuser.posts
      @albums = @theuser.albums
      @event = Event.new
      @events = Event.where(user_id: @theuser.id)

      # Count User-Got
      @posts = @theuser.posts
      @albums = @theuser.albums

      @get_likes = get_post(@posts, Like)
      @get_comments = get_post(@posts, PostComment)
      @get_bookmarks = get_album(@albums, Bookmark)

      # Count User-Gave
      @give_likes = give_obj(Like, @theuser)
      @give_comments = give_obj(PostComment, @theuser)
      @give_bookmarks = give_obj(Bookmark, @theuser)
      render user_path(current_user), notice: 'Event was failed to create.'
    end
  end

  def update
    event = find_event(params[:id])
    @events = Event.where(user_id: current_user.id)
    event.update(event_params)
  end

  def destroy
    @user = find_User(params[:id])
    event = Event.find(params[:id])
    if event.destroy
      redirect_to user_path(@user)
    end
  end

  private

  def find_event(event_id)
    Event.find(event_id)
  end

  def find_user(user_id)
    User.find(user_id)
  end

  def event_params
    params.require(:event).permit(:user_id, :genre_id, :title, :body, :start, :end)
  end

end

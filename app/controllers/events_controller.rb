class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  def addUser
     rdata=request.POST
     eve=rdata[:event]
     eve.AddUser(current_user)
     redirect_to '/home'
  end
  # GET /events/new
  def new
    @event = Event.new()
    @event.type = params[:type]
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events/1/addUser
  def addUser
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    dateTimeObj = DateTime.new(params[:date][:year].to_i,params[:date][:month].to_i,params[:date][:day].to_i,params[:date][:hour].to_i,params[:date][:minute].to_i)
    @event[:date] = dateTimeObj
    logger.debug @event.inspect
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :location, :eventdate, :description, :link)
    end
end

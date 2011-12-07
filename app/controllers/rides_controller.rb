class RidesController < ApplicationController
  before_filter :current_user
  before_filter :checker, :only => [:edit, :update, :destroy, :leave]
  before_filter :login_helper, :only => [:new, :join]
  
  # GET /rides
  # GET /rides.json
  def index
    @rides = Ride.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @rides }
    end
  end

  # GET /rides/1
  # GET /rides/1.json
  def show
    @ride = Ride.find(params[:id])
    @users = @ride.users

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @ride }
    end
  end

  # GET /rides/new
  # GET /rides/new.json
  def new
    @ride = @current_user.rides.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @ride }
    end
  end

  # GET /rides/1/edit
  def edit
    :checker
    @ride = Ride.find(params[:id])
    unless @current_user.rides.find_by_id(@ride.id)
      redirect_to root_url
    end
  end

  # POST /rides
  # POST /rides.json
  def create
    :checker
    @ride = @current_user.rides.new(params[:ride])
    @ride.users << @current_user

    respond_to do |format|
      if @ride.save
        format.html { redirect_to @ride, :notice => 'Ride was successfully created.' }
        format.json { render :json => @ride, :status => :created, :location => @ride }
      else
        format.html { render :action => "new" }
        format.json { render :json => @ride.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rides/1
  # PUT /rides/1.json
  def update
    :checker
    @ride = Ride.find(params[:id])
    
    respond_to do |format|
      if @ride.update_attributes(params[:ride])
        format.html { redirect_to @ride, :notice => 'Ride was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @ride.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rides/1
  # DELETE /rides/1.json
  def destroy
    :checker
    @ride = Ride.find(params[:id])
    if @current_user.rides.find_by_id(@ride.id)
      @ride.destroy

      respond_to do |format|
        format.html { redirect_to rides_url }
        format.json { head :ok }
      end
    else
      redirect_to root_url
    end
  end
  
  def join
    @ride = Ride.find(params[:id])
    unless @ride.users.find_by_id(@current_user.id)
      @ride.users << @current_user
      respond_to do |format|
        format.html { redirect_to @ride, :notice => 'You successfully joined this ride.' }
        format.json { head :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to @ride, :alert => 'You already joined that ride!' }
        format.json { head :ok }
      end
    end
  end
  
  def leave
    :checker
    @ride = Ride.find(params[:id])
    if @ride.users.find_by_id(@current_user.id)
      @ride.users.delete(@current_user)
      if @current_user.rides.find_by_id(@ride)
        @current_user.rides.delete(@ride)
      end
    end
    respond_to do |format|
      format.html { redirect_to :back, :confirm => 'Are you sure you want to leave this ride?' }
      format.json { head :ok }
    end
  end
  
  def toontario
    @airport = "to Ontario"
    @rides = Ride.find_all_by_airport("To Ontario")
    sort_rides(@rides)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @rides }
    end
  end
  
  def tolax
    @airport = "to LAX"
    @rides = Ride.find_all_by_airport("To LAX")
    sort_rides(@rides)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @rides }
    end
  end
  
  def fromontario
    @airport = "from Ontario"
    @rides = Ride.find_all_by_airport("From Ontario")
    sort_rides(@rides)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @rides }
    end
  end
  
  def fromlax
    @airport = "from LAX"
    @rides = Ride.find_all_by_airport("From LAX")
    sort_rides(@rides)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @rides }
    end
  end
  
  def sort_rides(rides)
    rides.sort! {|a,b| a.flighttime <=> b.flighttime}
  end
end

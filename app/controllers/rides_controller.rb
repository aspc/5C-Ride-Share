class RidesController < ApplicationController
  before_filter :current_user
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
    @ride = Ride.find(params[:id])
    unless @current_user.rides.find_by_id(@ride.id)
      redirect_to root_url
    end
  end

  # POST /rides
  # POST /rides.json
  def create
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
    if @current_user
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
    else
      session[:redirect_to] = :back
      redirect_to '/auth/facebook'
    end
  end
  
  def leave
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
  
  def ontario
    @rides = Ride.find_all_by_airport("Ontario")
    sort_rides(@rides)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @rides }
    end
  end
  
  def lax
    @rides = Ride.find_all_by_airport("LAX")
    sort_rides(@rides)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @rides }
    end
  end
  
  def sort_rides(rides)
    rides.sort! {|a,b| a.date <=> b.date}
  end
end

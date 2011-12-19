class RidesController < ApplicationController
  before_filter :checker, :only => [:edit, :update, :destroy, :leave]
  before_filter :login_helper, :only => [:new, :join]
  
  before_filter do
    @title = "5C ride share"
  end
  
  def index
    @title = "5C ride share :: home"
    @rides = Ride.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @rides }
    end
  end

  def show
    @ride = Ride.find(params[:id])
    @users = @ride.users

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @ride }
    end
  end

  def new
    @title = "5C ride share :: new"
    @ride = Ride.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @ride }
    end
  end

  def edit
    @ride = Ride.find(params[:id])
    unless @ride.owner_id == @current_user.id
      redirect_to :back, :alert => "You did not create that ride, therefore you cannot edit it."
    end
  end

  def create
    @ride = Ride.new(params[:ride])
    @ride.owner_id = @current_user.id
    @ride.users << @current_user

    respond_to do |format|
      if @ride.save
        format.html { redirect_to @ride, :notice => 'You successfully created a ride! Start the conversation below, so that when others comment you get a Facebook notification. Safe travels!' }
        format.json { render :json => @ride, :status => :created, :location => @ride }
      else
        format.html { render :action => "new" }
        format.json { render :json => @ride.errors, :status => :unprocessable_entity }
      end
    end
  end

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

  def destroy
    @ride = Ride.find(params[:id])
    if @ride.owner_id == @current_user.id
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
      if @ride.users
        @ride.users.each do |user|
          if user.email
            UserMailer.new_rider_email(user, @current_user, url_for(@ride)).deliver
          end
        end
      end
      @ride.users << @current_user
      
      respond_to do |format|
        format.html { redirect_to @ride, :notice => 'You successfully joined this ride. You should comment below, so when other riders comment, you get a Facebook notification. Safe Travels!' }
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
    @ride = Ride.find(params[:id])
    if @ride.users.find_by_id(@current_user.id)
      @ride.users.delete(@current_user)
      if @ride.owner_id == @current_user.id
        @ride.owner_id = nil
        @ride.save
      end
    end
    respond_to do |format|
      format.html { redirect_to :back, :confirm => 'Are you sure you want to leave this ride?' }
      format.json { head :ok }
    end
  end
  
  def toontario
    @title = "Rides to Ontario"
    @airport = "To Ontario"
    @ftype = "Departure"
    @rides = Ride.find_all_by_airport("To Ontario")
    sort_rides(@rides)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @rides }
    end
  end
  
  def tolax
    @title = "Rides to LAX"
    @airport = "To LAX"
    @ftype = "Departure"
    @rides = Ride.find_all_by_airport("To LAX")
    @rides = sort_rides(@rides)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @rides }
    end
  end
  
  def fromontario
    @title = "Rides from Ontario"
    @airport = "From Ontario"
    @ftype = "Arrival"
    @rides = Ride.find_all_by_airport("From Ontario")
    sort_rides(@rides)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @rides }
    end
  end
  
  def fromlax
    @title = "Rides from LAX"
    @airport = "From LAX"
    @ftype = "Arrival"
    @rides = Ride.find_all_by_airport("From LAX")
    sort_rides(@rides)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @rides }
    end
  end
  
  def sort_rides(rides)
    rides.sort! {|a,b| a.flighttime <=> b.flighttime}
    rides = rides.find_all{|ride| ride.flighttime > Time.now}
  end
end

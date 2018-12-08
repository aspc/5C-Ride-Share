class RidesController < ApplicationController
  before_filter :checker, :only => [:edit, :update, :destroy, :leave]
  before_filter :login_helper, :only => [:new, :join]
  
  before_filter do
    @title = "5C ride share"
  end
  
  def index
    @title = "5C ride share :: home"
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @rides }
    end
  end

  def show
    @ride = Ride.find(params[:id])
    @ride_user = RidesUser.find_by(:ride => @ride, :user => @current_user)
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
    @ride = Ride.new(ride_params)

    if @ride.is_aspc && @ride.existing_aspc_ride.present?
      return redirect_to join_rides_path(:id => @ride.existing_aspc_ride, :flighttime => @ride.flighttime)
    end

    @ride.owner_id = @current_user.id
    @ride.users << @current_user

    if @ride.is_aspc != true then @ride.is_aspc = false end

    respond_to do |format|
      if @ride.save

        @ride_user = RidesUser.find_by(:ride => @ride, :user => @current_user)
        @ride_user.flighttime = @ride.flighttime
        @ride_user.save

        notice_text = 'You successfully created a ride! When other riders comment, you\'ll get an email notification. Safe Travels!'
        if @ride.is_aspc
          notice_text = 'Your free ride request has been submitted to ASPC for processing. We will notify all applicants of their ride status soon. Thank you!'
        end

        format.html { redirect_to @ride, :notice => notice_text }
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
      if @ride.update_attributes(ride_params)
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
          if user.email && user.email_pref && user.email != "" && !@ride.is_aspc?
            begin
              UserMailer.new_rider_email(user, @current_user, url_for(@ride)).deliver
            rescue
              # Oops, an email error
            end
          end
        end
      end

      @ride.users << @current_user
      @ride.save

      if params[:flighttime]
        @ride_user = RidesUser.find_by(:ride => @ride, :user => @current_user)
        @ride_user.flighttime = params[:flighttime]
        @ride_user.save
      end
      
      respond_to do |format|

        notice_text = 'You successfully joined this ride. When other riders comment, you\'ll get an email notification. Safe Travels!'
        if @ride.is_aspc
          notice_text = 'Your free ride request has been submitted to ASPC for processing. We will notify all applicants of their ride status soon. Thank you!'
        end

        format.html { redirect_to @ride, :notice => notice_text }
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

  def aspc_rides
    airport = params[:airport]
    @rides = sort_rides(Ride.where(:airport => airport, :is_aspc => true).all)

    render :json => @rides
  end
  
  def airport
    info = airport_helper(params[:id])
    check = info[:check]

    @title = info[:title]
    @airport = info[:airport]
    @ftype = info[:ftype]
    @rides = info[:rides]
    @rides = sort_rides(@rides)
    @urides = @current_user.rides.to_set if @current_user
    if check
      respond_to do |format|
        format.html
        format.json {render :json => @rides}
      end
    else
      redirect_to root_url
    end
  end
  
  def airport_helper(type)
    case type
    when "1"
      {
      :title => "5C ride share :: to ontario",
      :airport => "To Ontario",
      :ftype => "Departure",
      :rides => Ride.where(airport: "To Ontario").all,
      :check => true
      }
    when "2"
      {
      :title => "5C ride share :: from ontario",
      :airport => "From Ontario",
      :ftype => "Arrival",
      :rides =>  Ride.where(airport: "From Ontario").all,
      :check => true
      }
    when "3"
      {
      :title => "5C ride share :: to LAX",
      :airport => "To LAX",
      :ftype => "Departure",
      :rides => Ride.where(airport: "To LAX").all,
      :check => true
      }
    when "4"
      {
      :title => "5C ride share :: from LAX",
      :airport => "From LAX",
      :ftype => "Arrival",
      :rides => Ride.where(airport: "From LAX").all,
      :check => true
      }
    else
      {
        :check => false
      }
    end
  end
  
  private

  def ride_params
    if params[:ride]
      params.require(:ride).permit("airport", "flighttime(1i)", "flighttime(2i)", "flighttime(3i)", "flighttime(4i)", "flighttime(5i)",
      "ridetime(1i)","ridetime(2i)","ridetime(3i)","ridetime(4i)","ridetime(5i)", "is_aspc", "existing_aspc_ride")
    end
  end
end

class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update]

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
    @beer_clubs = BeerClub.all
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  # POST /memberships.json
  def create
	
   
    @membership = Membership.new params.require(:membership).permit(:user_id, :beer_club_id)
 if not current_user.clubs.find_by id: @membership.beer_club_id
    if @membership.save 
      current_user.memberships << @membership
	flash[:notice] = "#{current_user.username}, welcome to the club!"
      redirect_to beer_club_path(@membership.beer_club_id)
    end
	 else
      @beer_clubs = BeerClub.all
      flash[:notice] = "Joining a club failed. Already a member of the club?"
      render :new
end
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    u = current_user.clubs.find_by id: @membership.beer_club_id 
    @membership = u.memberships.find_by user_id: current_user.id
@membership.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user.id) }
      format.json { head :no_content }
    end
	
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:user_id, :beer_club_id)
    end
end

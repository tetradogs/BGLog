class ListingsController < ApplicationController

  def index
  end

  def show
    @listing = Listing.find(params[:id])
  end

  #def new
      #  @listing =current_user.listings.build
  #end

  def create
        @listing =current_user.listings.build(listing_params)
        if @listing.save
          #redirect_to show_users_path(current_user)
          redirect_to edit_listing_path(@listing.id)
        else
          redirect_to new_listing_path
        end
  end

  def edit
    @listing = Listing.find(params[:id])
    if @listing.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to root_path
    end

  end

  def update
    @listing =Listing.find(params[:id])
    if @listing.update_attributes(listing_params)
      #redirect_to show_users_path(current_user)
      redirect_to listing_path(@listing)
    else
      redirect_to new_listing_path
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    if @listing.delete
      redirect_to show_users_path(current_user)
    end
  end

    def search
      @articles = Listing.search(params[:keyword])
    end

  private
  def listing_params
    params.require(:listing).permit(:game_title, :valuation,:classification,:status_have, :status_can_instruction,:status_verygood, :status_want, :game_content, :image, :game_player, :game_time ,:game_counting)
  end

end

class AddressesController < ApplicationController
  before_action :ensure_login

  def index
    @address  = current_user.addresses.paginate(:page => params[:page], :per_page=>5)
  end
  def new
		@address = Address.new
  end

  def edit
  	@address = Address.find(params[:id])
  end

  def show
    @address = Address.find(params[:id])
  end

  def create
		@address = Address.new(address_param)
	 	if @address.save
	 		render 'favorite', locals: { address: @address }
		else
			render 'new'
		end
  end

  def update
    redirect_to welcome_index_path
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end

  def  delete_all_method
    @address = current_user.addresses
    @address.destroy_all
    redirect_to addresses_path
  end 

  def favorite
    @address = Address.find(params[:id])
    if current_user.addresses << @address
      redirect_to addresses_path
    else
      flash[:notice] = "Please Try Again"
      render 'favorite', locals: { address: @address }
    end
  end

  private
  def address_param
  	params.require(:address).permit(:words, :add, :name, :lat, :lng)
  end
end

class StylesController < ApplicationController
before_action :set_style, only: [:show, :edit, :update]

  def index
	@styles = Style.all
  end
  
  def new
    @style = Style.new
  end
  
   def create
    @style = Style.new params.require(:style).permit(:beerstyle, :description)

    if current_user.nil?
          redirect_to signin_path, notice:'you should be signed in'
    elsif @style.save
      redirect_to styles_path
    else
      render :new
    end
  end
  def edit
  end

  def show
  end

   def destroy
    rating = Style.find(params[:id])
    rating.destroy if current_user
    redirect_to styles_path
  end

  def update
    respond_to do |format|
      if style_params[:beerstyle].nil? and @style.update(style_params)
        format.html { redirect_to @style, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @style.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def style_params
     params.require(:style).permit(:beerstyle, :description)
  end
  def set_style
   @style = Style.find(params[:id])
  end

end

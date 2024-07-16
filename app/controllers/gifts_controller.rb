class GiftsController < ApplicationController
  before_action :set_friend
  before_action :set_gift, only: [:show, :edit, :update, :destroy]

  def index
    @gifts = Gift.all
  end

  def new
    @gift = Gift.new
  end
  def show
    @gift
  end

  def create
    @gift = @friend.gifts.build(gift_params)

    if @gift.save
      respond_to do |format|
        format.turbo_stream { render 'gifts/turbo_stream' }
        format.html { redirect_to @friend, notice: 'Gift was successfully created.' }
      end
    else
      respond_to do |format|
        format.turbo_stream { render 'gifts/turbo_stream', status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    unless @gift
      respond_to do |format|
        format.turbo_stream { render 'gifts/turbo_stream', status: :not_found }
        format.html { redirect_to @friend, alert: 'Gift not found.' }
      end
    end
  end


  def update
    if @gift.update(gift_params)
      respond_to do |format|
        format.turbo_stream { render 'gifts/turbo_stream' }
        format.html { redirect_to @friend, notice: 'Gift was successfully updated.' }
      end
    else
      respond_to do |format|
        format.turbo_stream { render 'gifts/turbo_stream', status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @gift.destroy
    respond_to do |format|
      format.turbo_stream { render 'gifts/turbo_stream' }
      format.html { redirect_to @friend, notice: 'Gift was successfully destroyed.' }
    end
  end

  private

  def set_friend
    @friend = Friend.find(params[:friend_id])
  end

  def set_gift
    @gift = @friend.gifts.find_by(id: params[:id])
    if @gift.nil?
      redirect_to friend_path(@friend), alert: "Gift not found."
    end
  end

  def gift_params
    params.require(:gift).permit(:name, :price, :link)
  end
end

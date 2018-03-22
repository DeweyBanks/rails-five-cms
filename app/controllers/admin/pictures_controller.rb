module Admin
  class PicturesController < BaseController
    before_action :set_picture, only: [:show, :edit, :update, :destroy]

    def index
      @pictures = Picture.all
    end

    def new
      @picture = Picture.new
    end

    def edit
    end

    def create
      @picture = Picture.new(picture_params)

      respond_to do |format|
        if @picture.save
          format.html { redirect_to admin_pictures_path, notice: 'Picture was successfully created.' }
          format.json { render :show, status: :created, location: @picture }
        else
          format.html { render :new }
          format.json { render json: @picture.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @picture.update(picture_params)
          format.html { redirect_to admin_pictures_path, notice: 'Picture was successfully updated.' }
          format.json { render :show, status: :ok, location: @picture }
        else
          format.html { render :edit }
          format.json { render json: @picture.errors, status: :unprocessable_entity }
        end
      end
    end

    def show
      @picture = Picture.find(params[:id])
    end

    def destroy
      @picture = Picture.find(params[:id])
      @picture.destroy
      respond_to do |format|
        format.html { redirect_to admin_pictures_url, notice: 'Picture was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

      def set_picture
        @picture = Picture.find(params[:id])
      end

      def picture_params
        params.require(:picture).permit(
          :image,
          :post_id,
          :caption,
          :alt
          )
      end
  end
end

class ImagesController < ApplicationController

	def show
		@advertisement = Advertisement.find(params[:id])
		send_data(@advertisement.image, :disposition => 'inline')
		#render(text: @advertisement.image, content_type: "image/jpeg")
	end

end
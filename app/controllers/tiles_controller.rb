class TilesController < ApplicationController

	def new
		@advertisement = Advertisement.find(params[:advertisement_id])
		@tile = Tile.new()
	end

	def create
		@advertisement = Advertisement.find(params[:advertisment_id])
		@tile = @advertisement.tiles.build(params[:tile])
	end

end

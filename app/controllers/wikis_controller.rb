class WikisController < ApplicationController
	
	def index
		@wikis = Wiki.all
		# @wikis = Wiki.visible_to(current_user)
		authorize @wikis
	end
	
	def show
		@wiki = Wiki.find(params[:id])
	end
	
	def new
		@wiki = Wiki.new
		authorize @wiki
	end
	
	def create
		@wiki = current_user.wikis.build(params.require(:wiki).permit(:title, :outline, :body, :public))
		authorize @wiki
		if @wiki.save
			flash[:notice] = "Your wiki was saved."
			redirect_to @wiki
			else
			flash[:error] = "There was an error saving the wiki. Please try again."
			render :new
		end
	end
	
	def edit
		@wiki = Wiki.find(params[:id])
		authorize @wiki
	end
	
	def update
		@wiki = Wiki.find(params[:id])
		authorize @wiki
		if @wiki.update_attributes(params.require(:wiki).permit(:title, :outline, :body, :public))
			flash[:notice] = "Your wiki was updated."
			redirect_to @wiki
		else
			flash[:error] = "There was an error saving your wiki. Please try again."
			render :edit
     end
   end
	
end

class WikisController < ApplicationController
	
	def index
		@wikis = Wiki.all
		# @wikis = Wiki.visible_to(current_user)
		authorize @wikis
	end
	
	def show
		@wiki = Wiki.find(params[:id])
		@collaborations = @wiki.users
	end
	
	def new
		@wiki = Wiki.new
		@users = User.all_except(current_user)
		authorize @wiki
	end
	
	def create
		# @wiki = current_user.wikis.build(wiki_params)
		@wiki = Wiki.new(wiki_params)
		@wiki.user = current_user
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
		@users = User.all_except(current_user)
		authorize @wiki
		@collaborations = @wiki.collaborations
	end
	
	def update
		@wiki = Wiki.find(params[:id])
		authorize @wiki
		if @wiki.update_attributes(wiki_params)
			flash[:notice] = "Your wiki was updated."
			redirect_to @wiki
		else
			flash[:error] = "There was an error saving your wiki. Please try again."
			render :edit
     end
   end

   private 



  def wiki_params
    params.require(:wiki).permit(:title, :outline, :body, :public)
 end
	
end

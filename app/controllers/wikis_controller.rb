class WikisController < ApplicationController
	
	def index
		@wikis = Wiki.paginate(page: params[:page], per_page: 10)
		authorize @wikis
	end
	
	def show
      # check_membership
		@wiki = Wiki.find(params[:id])
		@collaborations = @wiki.users
	end
	
	def new
		@wiki = Wiki.new
		@users = User.all_except(current_user)
		authorize @wiki
	end
	
	def create
		@wiki = current_user.wikis.build(wiki_params)
		# @wiki = Wiki.new(wiki_params)
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

  	def destroy
    	@wiki = Wiki.find(params[:id])
    	if @wiki.destroy
      	flash[:notice] = "Your wiki was deleted." 
    	else
      	flash[:error] = 'There was an error deleting your wiki.  Try again.' 
    	end
    	redirect_to wikis_path
  	end

   private 

  	def wiki_params
   	params.require(:wiki).permit(:title, :outline, :body, :public)
	 end

	def check_membership
      if current_user == nil && !wiki.public?
         redirect_to new_user_registration_path
         flash[:notice] = "Premium members can see private wikis."
      elsif current_user && !wiki.public?
         flash[:notice] = "Premium members can see private wikis."
      end
   end
end

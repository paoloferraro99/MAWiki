class CollaborationsController < ApplicationController  
  
  def create
    @wiki = Wiki.find(params[:wiki_id])

    if params[:user_ids]
      @wiki.users = User.find(params[:user_ids]) 
    else
      @wiki.users = []
    end

    redirect_to @wiki, notice: 'Successfully added collaborators' 
  end    


  def destroy
    @collaboration = Collaboration.find(params[:id])
    @collaboration.destroy
    flash[:notice] = "Collaborator successfully removed."
    redirect_to @collaboration.wiki
  end

end
#miki user = User.sample
      #     @wiki.users << user
      #     user.collaborations.where(:user_id => user.id, :wiki_id => @wiki.id).destroy
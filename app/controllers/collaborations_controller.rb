class CollaborationsController < ApplicationController

  respond_to :html, :js
  
  def create
    @wiki = Wiki.find(params[:collaboration][:wiki_id])

    if params[:collaboration][:user_email].present?
      user = User.where(:email => params[:collaboration][:user_email]).first
      if user.present? && @wiki.collaborations.where(:user_id => user.id).first.blank?
        @wiki.users << user
      end
    end

    redirect_to @wiki, notice: 'Successfully added collaborators' 
  end    


  def destroy
    @collaboration = Collaboration.find(params[:id])
    if @collaboration.destroy
      flash[:notice] = "Collaborator successfully removed."
      # redirect_to @collaboration.wiki
    else
      flash[:error] = "Collaborator not removed.  Try again please,"
    end

    respond_with(@collaboration) do |format|
      format.html { redirect_to @collaboration }
    end

  end

end
#miki user = User.sample
      #     @wiki.users << user
      #     user.collaborations.where(:user_id => user.id, :wiki_id => @wiki.id).destroy

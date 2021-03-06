class CollaborationsController < ApplicationController

  respond_to :html, :js
  
  def create
    @wiki = Wiki.find(params[:collaboration][:wiki_id])

    if params[:collaboration][:user_email].present?

      user = User.where(:email => params[:collaboration][:user_email]).first

      if user.present? && @wiki.collaborations.where(:user_id => user.id).first.blank?
        @wiki.users << user
        flash[:notice] = "Collaborator successfully added."
      elsif user.present? && !@wiki.collaborations.where(:user_id => user.id).first.blank?
        flash[:error] = "They are already a collaborator.  Try again please."
      else
        flash[:error] = "Collaborator not found.  Try again please."
      end
    end
    # redirect_to edit_wiki_path(@wiki)
    ## redirect_to @wiki
      
    # AJAX _____

  # the ajay seems to be responding to this variable, when i change it the ajax is formatted differently
    @collaborator = user
    # ################### the _collaborator partial was not getting rendered at all for the way we discused
    
    respond_with(user) do |format|
      format.html { redirect_to edit_wiki_path(@wiki) }
    end
  end    


  def destroy
    @collaboration = Collaboration.find(params[:id])
    if @collaboration.destroy
      flash[:notice] = "Collaborator successfully removed."
      # redirect_to edit_wiki_path(@collaboration.wiki)
      ## redirect_to @collaboration.wiki
    else
      flash[:error] = "Collaborator not removed.  Try again please."
    end

    # AJAX _____
    respond_with(@collaboration) do |format|
      format.html { redirect_to edit_wiki_path(@collaboration.wiki) }
    end

  end

end
#miki user = User.sample
      #     @wiki.users << user
      #     user.collaborations.where(:user_id => user.id, :wiki_id => @wiki.id).destroy

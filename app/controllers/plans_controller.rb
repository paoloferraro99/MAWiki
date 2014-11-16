class PlansController < ApplicationController


  before_action :check_membership

  def new
    # will reender a page asking a user if he wants to be premium or not
  end

  def create
    # if user chose free, set his role to free

    # if he chose to pay, use stripe to charge

    # at the end redirect to root url
  end


def check_membership

  if current_user && current_user.role == 'premium'
    # flash[:notice] = "Congratulations, you are a premium member."
    redirect_to wikis_path, notice: "Congratulations, you are a premium member!"
  elsif current_user
    redirect_to new_charge_path
  elsif current_user == nil
    redirect_to new_user_registration_path
  end

end



end
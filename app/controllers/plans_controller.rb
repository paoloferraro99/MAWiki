class PlansController < ApplicationController

  def new
    # will reender a page asking a user if he wants to be premium or not
  end

  def create
    # if user chose free, set his role to free

    # if he chose to pay, use stripe to charge

    # at the end redirect to root url
  end

end
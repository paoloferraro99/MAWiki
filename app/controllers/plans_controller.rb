class PlansController < ApplicationController

  before_action :check_membership

# new
    # will render a page asking a user if he wants to be premium or not

# create
    # if user chose free, set his role to free

    # if he chose to pay, use stripe to charge

    # at the end redirect to root url

def new
    @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "Premium Membership - #{current_user.email}",
     amount: 99
   }
  end

  def create
    @amount = 99

# Creates a Stripe Customer object, for associating
   # with the charge
   customer = Stripe::Customer.create(
     email: current_user.email,
     card: params[:stripeToken]
   )
 
   # Where the real magic happens
   charge = Stripe::Charge.create(
     customer: customer.id, # Note -- this is NOT the user_id in your app
     amount: @amount,
     description: "Premium Membership - #{current_user.email}",
     currency: 'usd'
   )
 
   flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
   current_user.update_attribute(:role, 'premium')
   redirect_to wikis_path # or wherever
 
 # Stripe will send back CardErrors, with friendly messages
 # when something goes wrong.
 # This `rescue block` catches and displays those errors.
 rescue Stripe::CardError => e
   flash[:error] = e.message
   redirect_to new_plans_path

  end

private
def check_membership

  if current_user && current_user.role == 'premium'
    # flash[:notice] = "Congratulations, you are a premium member."
    redirect_to wikis_path, notice: "Congratulations, you are a premium member!"
  elsif current_user == nil
    redirect_to new_user_registration_path
  end

end



end
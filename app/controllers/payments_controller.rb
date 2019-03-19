class PaymentsController < ApplicationController

  def create
    #
    @user = get_current_user
    @payment = Payment.new(payment_params)
    if @payment.save
      render json: @payment
    else
      render json: {error: "Payment cannot be made."}, status: 401
    end
  end

  def payment_params
    params.permit(:bill_id, :paying_user_id, :submitting_user_id, :payment_amount)
  end

end

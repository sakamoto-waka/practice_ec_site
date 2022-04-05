# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
before_action :customer_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected
  # 退会しているユーザーか判断
  def customer_state
    @customer = Customer.fund_by(email: params[:customer][:email])
    # アカウントを取得できなければ（ユーザーがいなければ）そのままreturn
    return unless @customer
    if @customer.valid_password?(params[:customer][:password]) && !@customer.is_deleted　
        redirect_to public_signup_path

    end
  end
  

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

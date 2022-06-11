# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

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

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  protected
#会員情報を確認するコマンド
  def user_state
    #userテーブルからemail情報をもとにcustomerのデータを引き出す
    @user = User.find_by(email: params[:user][:email])
    #データが引き出せない場合は、処理を終了させる。
    return if !@user
    #パスワードがあってるいる、かつ、退会ステータスがtrueの場合処理を実行する
    if @user.valid_password?(params[:user][:password]) && @user.is_delete == true
      flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
      redirect_to new_user_registration_path
    end
  end
end

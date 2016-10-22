class CallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env['omniauth.auth'])
    set_flash_message(:notice, :success, kind: 'GitHub')
    sign_in_and_redirect @user
  end
end

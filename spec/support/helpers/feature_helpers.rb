module FeatureHelpers
  # Submits the current form (clicking on input or button)
  def click_on_submit_button
    find('*[type=submit]').click
  end

  # Fills out login form
  def sign_in(user)
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password

    click_on_submit_button
  end

  # Fills out all required fields in registration form
  def sign_up(user)
    fill_in 'user_email', with: user[:email]
    fill_in 'user_password', with: user[:password]
    fill_in 'user_password_confirmation', with: user[:password_confirmation]

    click_on_submit_button
  end
end

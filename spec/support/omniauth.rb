OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
  provider: :github,
  uuid: '1234',
  info: {
    email: 'info@example.com'
  }
})

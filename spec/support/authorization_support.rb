module AuthorizationSupport
  def sign_in(user)
    post "/auth/sign_in", params: { email: user.email ,password: user.password }
    return response.header.slice("access-token", "client", "uid")
  end
end
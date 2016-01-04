require 'devise'

include Warden::Test::Helpers
Warden.test_mode!

module ControllerHelpers
  def sign_in(user)
    no_user and return if user.nil?

    allow(request.env['warden'])
      .to receive(:authenticate!)
      .and_return(user)
    allow(controller)
      .to receive(:current_user)
      .and_return(user)
  end

  def no_user
    allow(request.env['warden'])
      .to receive(:authenticate!)
      .and_throw(:warden, scope: :user)
    allow(controller)
      .to receive(:current_user)
      .and_return(nil)
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include ControllerHelpers, type: :controller
end

module Warden
  class SessionOverride < Rails::Railtie
    config.after_initialize do
      Warden::Manager.serialize_into_session :user do
        {}
      end
    end
  end
end

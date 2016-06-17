Rails.application.config.middleware.use OmniAuth::Builder do
  provider :wechat, ENV["JILIN365_WECHAT_APP_ID"], ENV["JILIN365_WECHAT_APP_SECRET"], token_params: {:redirect_uri => "#{ENV['JILIN365_DOMAIN']}/auth/wechat/callback"}, callback_path: "/auth/wechat/callback"
end
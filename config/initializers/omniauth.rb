OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '135450493285811', '2896033cae2b1ce1d396ac41c7ef8fe2', {:scope => 'email, read_stream, read_friendlists, friends_likes, friends_status, offline_access'}
end

#TODO: Set the Env variables outside
OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '135450493285811', '2896033cae2b1ce1d396ac41c7ef8fe2'
end

#TODO: Set the Env variables outside
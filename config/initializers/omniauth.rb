Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
   '531508116561-bomiuledngrrcqp495p2i1tcbhhnutnu.apps.googleusercontent.com',
    '3RipsxjwRvFMZ8nPeA2eEPqk'

end
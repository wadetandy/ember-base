import LinkedInCallback from 'frontend/oauth-providers/linkedin'

export default {
  name: 'Oauth Callbacks',
  initialize: function(container, application) {
    container.register('torii-provider:linkedin-oauth-callback', LinkedInCallback)
  }
}

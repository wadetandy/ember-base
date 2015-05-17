import LinkedInOauth2 from 'torii/providers/linked-in-oauth2'
import CallbackBase from 'frontend/oauth-providers/callback-base'

export default LinkedInOauth2.extend(CallbackBase, {
  name: 'linkedin-oauth-callback'
})

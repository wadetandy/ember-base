import Ember from 'ember';
import OAuth2 from 'simple-auth-oauth2/authenticators/oauth2';

export default OAuth2.extend({
  authenticate: function(options) {
    return new Ember.RSVP.Promise(function(resolve, reject) {
      options.torii.open(options.provider).then(function(oauthData) {
        resolve(oauthData);
      }, function(error) {
        reject(error);
      });
    });
  }
});

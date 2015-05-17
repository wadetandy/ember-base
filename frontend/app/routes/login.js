import Ember from 'ember';

export default Ember.Route.extend({
  actions: {
    authenticateThirdParty: function(provider){
      provider = 'linkedin'
      this.get('session').authenticate('authenticator:torii-oauth2', {
        torii: this.get('torii'),
        provider: provider + '-oauth-callback'
      }, function(error) {
        alert('There was an error when trying to sign you in: ' + error);
      });
    }
  }
});

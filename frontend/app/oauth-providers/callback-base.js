export default {
  responseParams: ['email', 'token'],
  open: function(){
    var name        = this.get('name'),
        url         = this.buildUrl(),
        redirectUri = this.get('redirectUri'),
        responseParams = this.get('responseParams'),
        responseType = this.get('responseType');

    return this.get('popup').open(url, responseParams).then(function(authData){
      var missingResponseParams = [];

      responseParams.forEach(function(param){
        if (authData[param] === undefined) {
          missingResponseParams.push(param);
        }
      });

      if (missingResponseParams.length){
        throw new Error("The response from the provider is missing " +
              "these required response params: " + responseParams.join(', '));
      }

      return Ember.merge({provider: name}, authData)
    });
  }
}

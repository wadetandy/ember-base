import DS from 'ember-data';

var User = DS.Model.extend({
  name      :  DS.attr(),
  email     :  DS.attr(),
  bio       :  DS.attr(),
  avatarUrl :  DS.attr(),
  createdAt :  DS.attr()
});

User.reopenClass({
  FIXTURES: [{
    id: 1,
    name: 'Sponge Bob',
    email: 'bob@sponge.com',
    bio: 'Lorem ispum dolor sit amet in voluptate fugiat nulla pariatur.',
    avatarUrl: 'http://jkneb.github.io/ember-crud/assets/images/avatars/sb.jpg',
    createdAt: 'Mon, 26 Aug 2013 20:23:43 GMT'
  }, {
    id: 2,
    name: 'John David',
    email: 'john@david.com',
    bio: 'Lorem ispum dolor sit amet in voluptate fugiat nulla pariatur.',
    avatarUrl: 'http://jkneb.github.io/ember-crud/assets/images/avatars/jk.jpg',
    createdAt: 'Fri, 07 Aug 2013 10:10:10 GMT'
  }]
})

export default User

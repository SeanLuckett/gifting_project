define([
  'backbone'
], function( Backbone ){

  // collection view
  var FriendsView = Backbone.View.extend({
    el: $('#friends-list'),
    events: {
      "submit form": "save_chosen_friends"
    },
    save_chosen_friends: function(e){
      // figure out what this sends and see if controller can iterate on it
      // Backbone.sync("create", this.collection)
      var chosen_friends = this.collection.getChosen();

      _.each(chosen_friends, function(friend){
        delete( friend.user_chosen );
        Backbone.sync("create", friend);
      });
      return false;
    }
  });

  return FriendsView;
});
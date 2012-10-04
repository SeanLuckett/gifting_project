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
      var chosen_friends = this.collection.getChosen();
      
      _.each(chosen_friends, function(friend){
        Backbone.sync("create", friend);
      });
      return false;
    }
  });

  return FriendsView;
});
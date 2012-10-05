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

      $.when(function(){
        _.each(chosen_friends, function(friend){
          Backbone.sync("create", friend);
        });
      }).then(function(){
        window.location = "/dashboard/index";
      });

      return false;
    }
  });

  return FriendsView;
});
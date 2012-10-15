define([
  'backbone'
], function( Backbone ){

  // collection view
  var FriendsView = Backbone.View.extend({
    el: $('#friends-list'),
    events: {
      "submit form": "saveChosenFriends"
    },
    saveChosenFriends: function(e){
      var chosenFriends = this.collection.getChosen();

      $.when(function(){
        _.each(chosenFriends, function(friend){
          Backbone.sync("create", friend);
          console.log(friend);
        });
      }).then(function(){
        window.location = "/dashboard/index";
      });

      return false;
    }
  });

  return FriendsView;
});
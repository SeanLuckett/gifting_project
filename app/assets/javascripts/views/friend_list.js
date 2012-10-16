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
      var dfds = [];

        _.each(chosenFriends, function(friend){
          dfds.push(friend.save());
        });
      $.when( dfds ).then(function(){
        // window.location = "/dashboard/index";
      });

      return false;
    }
  });

  return FriendsView;
});
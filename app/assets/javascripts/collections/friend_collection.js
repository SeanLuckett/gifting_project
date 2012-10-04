define([
  'backbone'
  , 'models/friend'
], function( Backbone, Friend ){
  
  var FriendCollection = Backbone.Collection.extend({
    model: Friend,
    url: function(){
      var user_id = $("#friends-list ul").data("user_id");
      return '/users/' + user_id +  '/recipients';
    },

    getChosen: function() {
      return this.where({ "user_chosen": true })
    },

    getNotChosen: function() {
      return this.where({ "user_chosen": false })
    }
  });

  return FriendCollection;
});
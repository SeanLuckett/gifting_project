define([
  'backbone'
  , 'models/friend'
], function( Backbone, Friend ){
  
  var FriendCollection = Backbone.Collection.extend({
    model: Friend,

    getSelected: function() {
      return this.where({ "selected": true })
    },

    getUnselected: function() {
      return this.where({ "selected": false })
    }
  });

  return FriendCollection;
});
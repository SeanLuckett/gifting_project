define([
  'backbone'
  , 'views/friend'
], function( Backbone, FriendView ){
  
  var Friend = Backbone.Model.extend({
    initialize: function(){
      this.view = new FriendView({ model: this });
    },

    defaults: {
      selected: false
    },

    toggleSelectFriend: function(){
      this.model.set( 'selected', !this.selected );
    }
  });

  return Friend;
});
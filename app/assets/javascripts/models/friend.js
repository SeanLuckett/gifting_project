define([
  'backbone',
  'views/friend'
], function( Backbone, FriendView ){
  
  var Friend = Backbone.Model.extend({
    initialize: function(){
      this.view = new FriendView({ model: this });
    },

    defaults: {
      user_chosen: false
    },

    toggleChooseFriend: function(){
      this.set( 'user_chosen', !this.get("user_chosen") );
    }
  });

  return Friend;
});
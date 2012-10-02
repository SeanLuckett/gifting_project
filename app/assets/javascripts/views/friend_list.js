define([
  'backbone'
], function( Backbone ){

  // collection view
  var FriendsView = Backbone.View.extend({
    el: $('#friends-list')
  });

  return FriendsView;
});
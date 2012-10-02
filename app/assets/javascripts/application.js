require([
  'underscore'
  , 'backbone'
  , 'views/friend_list'
  , 'collections/friend_collection'
], function(_, Backbone, FriendsList, FriendsCollection){

  window.fb_friends.then(function( friends ){
    var collection = new FriendsCollection( friends );
    window.Friends =  new FriendsList({ collection: collection });
  }, function(){
    // error msg produced by FB.getLoginStatus
  });

});
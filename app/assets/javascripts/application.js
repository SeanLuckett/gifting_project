require([
  'underscore',
  'backbone',
  'views/friend_list',
  'collections/friend_collection',
  'models/friend'
], function(_, Backbone, FriendsList, FriendsCollection, Friend){

  window.init_facebook_data = function(fb_obj){
    fb_obj.fb_id = fb_obj.id;
    delete( fb_obj.id );

    fb_obj.image = "https://graph.facebook.com/" + fb_obj.fb_id + "/picture";

    return fb_obj;
  };

  if (window.fb_friends){
    window.fb_friends.then(function( friends ){
      var collection = new FriendsCollection();

      _.each(friends,function(friend){
        collection.add(init_facebook_data(friend));
      });

      window.Friends =  new FriendsList({ collection: collection });
      
    }, function(e){
      // error msg produced by FB.getLoginStatus
      var msg = '<h4>' + e + '</h4>';
      $("#fb-root").html(msg);
    });
  }
});


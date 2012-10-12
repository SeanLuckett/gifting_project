require([
  'underscore',
  'backbone',
  'views/friend_list',
  'collections/friend_collection',
  'models/friend'
], function(_, Backbone, FriendsList, FriendsCollection, Friend){

  // Facebook delivers the goods in either the wrong format or missing attributes
  // This changes the id attr to fb_id so Backbone recognizes it as a new model.
  // It also creates an http request for the friend's image/avatar
  window.init_facebook_data = function(fb_obj){
    fb_obj.fb_id = fb_obj.id;
    delete( fb_obj.id );

    fb_obj.image = "https://graph.facebook.com/" + fb_obj.fb_id + "/picture";

    return fb_obj;
  };

  if ( window.fb_friends ){
    window.fb_friends.then(function( friends ){
      var collection = new FriendsCollection();

      _.each( friends,function( friend ){
        collection.add( window.init_facebook_data( friend ) );
      });

      window.Friends =  new FriendsList( { collection: collection } );
      
    }, function( e ){
      // error msg produced by FB.getLoginStatus
      var msg = '<h4>' + e + '</h4>';
      $("#fb-root").html(msg);
    });
  }
});


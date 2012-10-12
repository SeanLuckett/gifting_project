require([
  'underscore',
  'backbone',
  'views/friend_list',
  'collections/friend_collection',
  'models/friend',
  'giftola',
  'facebook'
], function(_, Backbone, FriendsList, FriendsCollection, Friend, Giftola, Facebook){

  Giftola.FB = Facebook;
  Giftola.init = function(){
    Giftola.FB.init();
  };
  window.Giftola = Giftola;

  $(document).ready(function(){
    Giftola.init();
  });
});


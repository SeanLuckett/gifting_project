require([
  'underscore',
  'backbone',
  'views/friend_list',
  'models/friend',
  'giftola',
  'facebook'
], function(_, Backbone, FriendsList, Friend, Giftola, Facebook){

  Giftola.FB = Facebook;
  Giftola.init = function(){
    Giftola.FB.init();
  };

  window.Giftola = Giftola;
  $(document).ready(function(){
    Giftola.init();
  });
});


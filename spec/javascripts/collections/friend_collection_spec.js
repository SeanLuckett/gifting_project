require([
  'collections/friend_collection'
  , 'models/friend'
  ]
  , function( FriendCollection, Friend ){

  describe("FriendCollection", function(){
    var friends;

    beforeEach(function(){
      friends = new FriendCollection();
    });

    it("is valid", function(){
      expect(friends).toBeDefined();
    });

    it("contains Friend objects", function(){
      expect(friends.model).toEqual(Friend);
    });

    it("is empty when created", function(){
      expect(friends.length).toEqual(0);
    });

    it("can add a friend", function(){
      friends.add(new Friend());
      expect(friends.length).toEqual(1);
    });

    it("can return just selected friends", function(){
      friend_1 = new Friend({ selected: true });
      friend_2 = new Friend({ selected: true });
      friend_3 = new Friend({ selected: false });
      friends.add([friend_1, friend_2, friend_3]);

      selected_friends = friends.getSelected();

      expect(selected_friends.length).toEqual(2);
    });

    it("can return just unselected friends", function(){
      friend_1 = new Friend({ selected: true });
      friend_2 = new Friend({ selected: true });
      friend_3 = new Friend({ selected: false });
      friends.add([friend_1, friend_2, friend_3]);

      selected_friends = friends.getUnselected();

      expect(selected_friends.length).toEqual(1);
    });
  });
});
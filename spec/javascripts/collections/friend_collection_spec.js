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
      friends.add(new Friend({ id: 1 }));
      expect(friends.length).toEqual(1);
    });

  });
});
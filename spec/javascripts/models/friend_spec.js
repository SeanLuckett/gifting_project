require(['models/friend'], function( Friend ){

  describe("Friend", function(){
    var friend = new Friend()

    it("is valid", function(){
      expect(friend).toBeDefined();
    });

    it("is not selected", function(){
      expect(friend.get('selected')).toBeDefined();
      expect(friend.get('selected')).toBeFalsy();
    });

    it("has a view", function(){
      expect(friend.view).toBeDefined();
    });
  });

});

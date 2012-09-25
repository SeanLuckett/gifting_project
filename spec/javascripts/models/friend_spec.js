require(['models/friend'], function( Friend ){

  describe("Friend", function(){

    it("is valid", function(){
      var friend = new Friend()
      expect(friend).toBeDefined()
    })

  });

});

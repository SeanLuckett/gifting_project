define([
  'backbone', 
  'tpl!templates/friends_collection.html'
], function(Backbone, friendTemplate){

  var FriendView = Backbone.View.extend({
    tagName: 'label',
    className: 'well large-well fb-friend',

    initialize: function(){
      $('#friends-list ul').append( this.render() );

      this.model.on('change', this.render, this);

      this.model.on('change:user_chosen', function(model, user_chosen){
        this.$el[ user_chosen ? 'addClass' : 'removeClass' ]('user-chosen');
      }, this);
    },

    render: function(){
    this.$el.html( this.template({ friend: this.model.toJSON() }) );
      return this.el;
    },

    template: friendTemplate,
    events: {
      'change input': 'user_chosen'
    },

    user_chosen: function(e){
      this.model.toggleChooseFriend();
    }
  });

  return FriendView;
});
define([
  'backbone'
  , 'tpl!templates/friends_collection.html'
], function(Backbone, friendTemplate){

/*
/*  To display friend profile pic:
/*  <img src="graph.facebook.com/user_id/picture" />
*/

  var FriendView = Backbone.View.extend({
    tagName: 'li',
    className: 'fb-friend',

    initialize: function(){
      $('#friends-list').append( this.render() );

      this.model.on('change', this.render, this);

      this.model.on('change:selected', function(model, selected){
        this.$el[ selected ? 'addClass' : 'removeClass' ]('selected');
      }, this);
    },

    render: function(){
      this.$el.html( this.template(this.model.toJSON()) );
      return this.el;
    },

    template: friendTemplate,
    events: {
      'change input': 'selected'
    },

    selected: function(e){
      this.model.toggleSelectFriend();
    }
  });

  return FriendView;
});
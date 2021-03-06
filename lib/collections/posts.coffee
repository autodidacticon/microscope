@Posts = new Mongo.Collection 'posts'

Meteor.methods
  postInsert: (postAttributes) ->
    check Meteor.userId(), String
    check postAttributes,
      title: String,
      url: String
    
    duplicatePost = Posts.findOne url: postAttributes.url
    if duplicatePost
      return postExists: true, _id: duplicatePost._id

    user = Meteor.user()
    post = _.extend postAttributes,
      userId: user._id,
      author: user.username,
      submitted: new Date()

    postId = Posts.insert post
    
    _id: postId

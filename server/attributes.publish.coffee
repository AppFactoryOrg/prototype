Meteor.publish 'Attributes', (document) ->
	return Attributes.find('document_id': document._id)
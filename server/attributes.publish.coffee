Meteor.publish 'Attributes', (document_id) ->
	return Attributes.find('document_id': document_id)
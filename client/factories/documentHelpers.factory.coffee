angular.module('app-factory').factory 'DocumentHelpers', ->
	getDocumentDisplayName: (document, attribute) ->
		return unless document?
		return unless document.data.hasOwnProperty(attribute._id)
		document_id = document.data[attribute._id]
		document = Documents.findOne(document_id)
		return unless document?
		documentSchema = DocumentSchemas.findOne(document.document_schema_id)
		return unless documentSchema.primary_attribute_id
		return unless document.data.hasOwnProperty(documentSchema.primary_attribute_id)
		return document.data[documentSchema.primary_attribute_id]
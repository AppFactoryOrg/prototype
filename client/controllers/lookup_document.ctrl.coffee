angular.module('app-factory').factory 'LookupDocumentModal', ->
	return ({documentSchemaId}) ->
		templateUrl: 'client/templates/lookup_document.template.html'
		controller: 'LookupDocumentCtrl'
		size: 'large'
		resolve:
			'documentSchemaId': -> documentSchemaId

angular.module('app-factory').controller 'LookupDocumentCtrl', ($scope, $stateParams, $filter, $rootScope, $meteor, $modalInstance, documentSchemaId, ATTRIBUTE_TYPES) ->
	application_id = $stateParams.application_id
	
	$meteor.autorun $scope, ->
		$scope.documentSchema = DocumentSchemas.findOne('_id': documentSchemaId)
		$scope.attributes     = Attributes.find('document_schema_id': documentSchemaId).fetch()
		$scope.documents      = Documents.find('application_id': application_id, 'document_schema_id': documentSchemaId).fetch()

	$scope.formatDocumentData = (document, attribute) ->
		key = attribute['_id']
		return unless document.data.hasOwnProperty(key)
		value = document.data[key]
		return switch attribute.type
			when ATTRIBUTE_TYPES['Text'] then value
			when ATTRIBUTE_TYPES['Number'] then $filter('number')(value, 2)
			when ATTRIBUTE_TYPES['Date'] then $filter('date')(value, 'shortDate')
			when ATTRIBUTE_TYPES['Currency'] then $filter('currency')(value, '$', 2)
			else value

	$scope.choose = (document) ->
		$modalInstance.close( document )
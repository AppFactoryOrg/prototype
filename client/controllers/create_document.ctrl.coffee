angular.module('app-factory').factory 'CreateDocumentModal', ->
	return ({documentSchema}) ->
		templateUrl: 'client/templates/edit_document.template.html'
		controller: 'CreateDocumentCtrl'
		resolve:
			'documentSchema': -> documentSchema

angular.module('app-factory').controller 'CreateDocumentCtrl', ($scope, $modal, $rootScope, $upload, $meteor, $modalInstance, $stateParams, documentSchema, LookupDocumentModal, DocumentHelpers) ->
	application_id = $stateParams.application_id
	
	$scope.createMode = true
	$scope.documentSchema = documentSchema
	$scope.attributes = $meteor.collection -> Attributes.find('document_schema_id': documentSchema['_id'])
	$scope.uploading = false

	$scope.document =
		'application_id': application_id
		'document_schema_id': documentSchema['_id']
		'data': {}

	$scope.uploadImage = (attribute, files) ->
		return unless files.length > 0
		$scope.uploading = true
		upload = $upload.upload
			url: "https://api.cloudinary.com/v1_1/" + $.cloudinary.config().cloud_name + "/upload"
			file: files[0]
			fields: {upload_preset: $.cloudinary.config().upload_preset}

		upload.success (data, status, headers, config) ->
			$scope.document.data[attribute['_id']] = data.public_id
			$scope.uploading = false
			$scope.$apply() unless $scope.$$phase

	$scope.clearImage = (attribute) ->
		$scope.document.data[attribute._id] = null

	$scope.selectDocument = (attribute) ->
		documentSchemaId = attribute.document_type
		modal = $modal.open(new LookupDocumentModal({documentSchemaId}))
		modal.result.then (document) ->
			$scope.document.data[attribute._id] = document._id

	$scope.clearDocument = (attribute) ->
		$scope.document.data[attribute._id] = null

	$scope.getDocumentDisplayName = (attribute) ->
		DocumentHelpers.getDocumentDisplayName($scope.document, attribute)

	$scope.submit = ->
		$modalInstance.close( $scope.document )
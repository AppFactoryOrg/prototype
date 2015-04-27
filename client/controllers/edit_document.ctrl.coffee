angular.module('app-factory').factory 'EditDocumentModal', ->
	return ({document, documentSchema}) ->
		templateUrl: 'client/templates/edit_document.template.html'
		controller: 'EditDocumentCtrl'
		resolve:
			'document': -> document
			'documentSchema': -> documentSchema

angular.module('app-factory').controller 'EditDocumentCtrl', ($scope, $rootScope, $meteor, $modal, $modalInstance, $upload, document, documentSchema, LookupDocumentModal, ATTRIBUTE_TYPES, DocumentHelpers) ->
	$scope.document = angular.copy(document)
	$scope.documentSchema = documentSchema
	$scope.attributes = Attributes.find('document_schema_id': documentSchema._id).fetch()
	$scope.uploading = false

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

	$scope.canEditAttribute = (attribute) ->
		return false if attribute.type is ATTRIBUTE_TYPES['ROUTINE']
		return true

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
angular.module('app-factory').directive 'afScreenSchema', ($meteor, $modal, $stateParams, $compile, VIEW_TYPES, CreateViewModal, EditViewModal) ->
	restrict: 'E'
	templateUrl: 'client/templates/screen_schema.template.html'
	scope:
		screenSchema: '='
		onDeleted: '&'
	link: ($scope, $element, $attributes) ->

		$scope.blueprintId = $stateParams.blueprint_id
		$scope.viewTypes = VIEW_TYPES

		$meteor.subscribe('DocumentSchemas', $scope.blueprintId)
		$meteor.subscribe('Views', $scope.blueprintId)

		$meteor.autorun $scope, ->
			screenSchema = $scope.getReactively('screenSchema')
			return unless screenSchema?
			$scope.views = Views.find('screen_schema_id': screenSchema._id).fetch()

		$scope.saveScreenSchema = ->
			$meteor.collection(ScreenSchemas).save($scope.screenSchema)
			$scope.selectedScreenSchema = null
			mixpanel.track('screenSchema_updated')

		$scope.deleteScreenSchema = ->
			return unless confirm('Are you sure?')
			$meteor.collection(ScreenSchemas).remove($scope.screenSchema._id)
			$scope.onDeleted()
			mixpanel.track('screenSchema_deleted')

		$scope.getDocumentName = (documentSchemaId) ->
			documentSchema = DocumentSchemas.findOne(documentSchemaId)
			return documentSchema?.name

		$scope.addView = ->
			screenSchema = $scope.screenSchema
			
			modal = $modal.open(new CreateViewModal({screenSchema}))
			modal.result.then (view) ->
				$meteor.collection(Views).save(view)
				mixpanel.track('screenView_created')

		$scope.editView = (view) ->
			screenSchema = $scope.screenSchema
			
			modal = $modal.open(new EditViewModal({view, screenSchema}))
			modal.result.then (view) ->
				$meteor.collection(Views).save(view)
				mixpanel.track('screenView_updated')

		$scope.deleteView = (view) ->
			return unless window.confirm('Are you sure?')
			$meteor.collection(Views).remove(view)
			mixpanel.track('screenView_deleted')
angular.module('app-factory').directive 'afListView', ($meteor, $filter, $modal, CreateDocumentModal, EditDocumentModal, ViewImageModal, ATTRIBUTE_TYPES, DocumentHelpers) ->
	restrict: 'E'
	templateUrl: 'client/templates/list_view.template.html'
	controller: 'DocumentViewCtrl'
	scope:
		view: '='
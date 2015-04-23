angular.module('app-factory').directive 'afTableView', ($meteor, $filter, $modal, CreateDocumentModal, EditDocumentModal, ViewImageModal, ATTRIBUTE_TYPES, DocumentHelpers) ->
	restrict: 'E'
	templateUrl: 'client/templates/table_view.template.html'
	controller: 'DocumentViewCtrl'
	scope:
		view: '='
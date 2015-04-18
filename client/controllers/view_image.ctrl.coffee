angular.module('app-factory').factory 'ViewImageModal', ->
	return ({imageId}) ->
		templateUrl: 'client/templates/view_image.template.html'
		controller: 'ViewImageCtrl'
		windowClass: 'view-image-modal'
		resolve:
			'imageId': -> imageId

angular.module('app-factory').controller 'ViewImageCtrl', ($scope, imageId) ->
	$scope.imageId = imageId
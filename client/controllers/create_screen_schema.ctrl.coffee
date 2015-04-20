angular.module('app-factory').factory 'CreateScreenSchemaModal', ->
	return ({blueprint}) ->
		templateUrl: 'client/templates/create_screen_schema.template.html'
		controller: 'CreateScreenSchemaCtrl'
		resolve:
			'blueprint': -> blueprint

angular.module('app-factory').controller 'CreateScreenSchemaCtrl', ($scope, $meteor, $modalInstance, blueprint) ->
	$scope.screenSchema =
		'name': ''
		'blueprint_id': blueprint['_id']
		'layout': {container: 'vertical', children: []}

	$scope.submit = ->
		$modalInstance.close( $scope.screenSchema )
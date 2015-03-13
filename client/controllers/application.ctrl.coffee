angular.module('app-factory').controller 'ApplicationCtrl', ($scope, $meteor, $stateParams) ->
	application_id = $stateParams.application_id

	$scope.application = $meteor.object(Applications, application_id).subscribe('Applications');
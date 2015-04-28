angular.module('app-factory').factory 'CreateApplicationModal', ->
	return ->
		templateUrl: 'client/templates/create_application.template.html'
		controller: 'CreateApplicationCtrl'

angular.module('app-factory').controller 'CreateApplicationCtrl', ($scope, $rootScope, $meteor, $modalInstance) ->
	$scope.themes = [
		{name:'Cerulean', key: 'cerulean'}
		{name:'Cosmo', key: 'cosmo'}
		{name:'Cyborg', key: 'cyborg'}
		{name:'Darkly', key: 'darkly'}
		{name:'Flatly', key: 'flatly'}
		{name:'Journal', key: 'journal'}
		{name:'Lumen', key: 'lumen'}
		{name:'Paper', key: 'paper'}
		{name:'Readable', key: 'readable'}
		{name:'Sandstone', key: 'sandstone'}
		{name:'Simplex', key: 'simplex'}
		{name:'Slate', key: 'slate'}
		{name:'Spacelab', key: 'spacelab'}
		{name:'Superhero', key: 'superhero'}
		{name:'United', key: 'united'}
		{name:'Yeti', key: 'yeti'}
	]

	$scope.name = ''
	$scope.selectedTheme = $scope.themes[0].key

	$scope.submit = ->
		$modalInstance.close
			'name': $scope.name
			'theme': $scope.selectedTheme
			'owner_id': $rootScope.currentUser['_id']
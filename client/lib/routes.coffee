angular.module('app-factory').config ($urlRouterProvider, $stateProvider) ->

	$stateProvider

		.state 'home',
			url: '/home'
			templateUrl: 'client/templates/home.template.html'

		.state 'blueprints',
			url: '/blueprints'
			templateUrl: 'client/templates/blueprints.template.html'

		.state 'blueprint',
			url: '/blueprint/:blueprint_id'
			templateUrl: 'client/templates/blueprint.template.html'

		.state 'apps',
			url: '/apps'
			templateUrl: 'client/templates/apps.template.html'
	
	$urlRouterProvider.otherwise '/home'

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

		.state 'applications',
			url: '/applications'
			templateUrl: 'client/templates/applications.template.html'

		.state 'application',
			url: '/application/:application_id'
			templateUrl: 'client/templates/application.template.html'
	
	$urlRouterProvider.otherwise '/home'

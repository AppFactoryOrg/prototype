angular.module 'app-factory', [
	'angular-meteor'
	'ui.router'
	'ui.bootstrap'
	'xeditable'
]

angular.module('app-factory').run (editableOptions) ->
	editableOptions.theme = 'bs3'
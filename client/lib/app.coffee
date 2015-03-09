angular.module 'app-factory', [
	'angular-meteor'
	'ui.router'
	'xeditable'
]

angular.module('app-factory').run (editableOptions) ->
	editableOptions.theme = 'bs3'
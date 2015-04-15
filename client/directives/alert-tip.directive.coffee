angular.module('app-factory').directive 'alertTip', ($rootScope) ->
	restrict: 'C'
	link: ($scope, $element, $attributes) ->
		$rootScope.$watch 'currentUser', ->
			$element.hide() if $rootScope.currentUser?.hideTutorials is true
		, true

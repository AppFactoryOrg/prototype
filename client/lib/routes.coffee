Router.map ->
	@route 'home',
		path: '/'

	@route 'blueprints',
		path: '/blueprints'

	@route 'blueprint',
		path: '/blueprint/:id'

	@route 'apps',
		path: '/apps'
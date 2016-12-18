/**
 * @author mrdoob / http://mrdoob.com/
 */

var Cache = {

	enabled: false,

	files: {},

	add: function ( key, file ) {

		if ( this.enabled === false ) return;

		// console.log( 'THREE.Cache', 'Adding key:', key );

		this.files[ key ] = file;

	},

	get: function ( key ) {

		if ( this.enabled === false ) return;

		// console.log( 'THREE.Cache', 'Checking key:', key );

		return this.files[ key ];

	},

	remove: function ( key ) {

		delete this.files[ key ];

	},

	clear: function () {

		this.files = {};

	}

};

function LoadingManager( onLoad, onProgress, onError ) {

	var scope = this;

	var isLoading = false, itemsLoaded = 0, itemsTotal = 0;

	this.onStart = undefined;
	this.onLoad = onLoad;
	this.onProgress = onProgress;
	this.onError = onError;

	this.itemStart = function ( url ) {

		itemsTotal ++;

		if ( isLoading === false ) {

			if ( scope.onStart !== undefined ) {

				scope.onStart( url, itemsLoaded, itemsTotal );

			}

		}

		isLoading = true;

	};

	this.itemEnd = function ( url ) {

		itemsLoaded ++;

		if ( scope.onProgress !== undefined ) {

			scope.onProgress( url, itemsLoaded, itemsTotal );

		}

		if ( itemsLoaded === itemsTotal ) {

			isLoading = false;

			if ( scope.onLoad !== undefined ) {

				scope.onLoad();

			}

		}

	};

	this.itemError = function ( url ) {

		if ( scope.onError !== undefined ) {

			scope.onError( url );

		}

	};

}

var DefaultLoadingManager = new LoadingManager();




function FileLoader( manager ) {

	this.manager = ( manager !== undefined ) ? manager : DefaultLoadingManager;

}

Object.assign( FileLoader.prototype, {

	load: function ( url, onLoad, onProgress, onError ) {

		if ( url === undefined ) url = '';

		if ( this.path !== undefined ) url = this.path + url;

		var scope = this;

		var cached = Cache.get( url );

		if ( cached !== undefined ) {

			scope.manager.itemStart( url );

			setTimeout( function () {

				if ( onLoad ) onLoad( cached );

				scope.manager.itemEnd( url );

			}, 0 );

			return cached;

		}

		// Check for data: URI
		var dataUriRegex = /^data:(.*?)(;base64)?,(.*)$/;
		var dataUriRegexResult = url.match( dataUriRegex );

		// Safari can not handle Data URIs through XMLHttpRequest so process manually
		if ( dataUriRegexResult ) {

			var mimeType = dataUriRegexResult[ 1 ];
			var isBase64 = !! dataUriRegexResult[ 2 ];
			var data = dataUriRegexResult[ 3 ];

			data = window.decodeURIComponent( data );

			if ( isBase64 ) data = window.atob( data );

			try {

				var response;
				var responseType = ( this.responseType || '' ).toLowerCase();

				switch ( responseType ) {

					case 'arraybuffer':
					case 'blob':

					 	response = new ArrayBuffer( data.length );

						var view = new Uint8Array( response );

						for ( var i = 0; i < data.length; i ++ ) {

							view[ i ] = data.charCodeAt( i );

						}

						if ( responseType === 'blob' ) {

							response = new Blob( [ response ], { type: mimeType } );

						}

						break;

					case 'document':

						var parser = new DOMParser();
						response = parser.parseFromString( data, mimeType );

						break;

					case 'json':

						response = JSON.parse( data );

						break;

					default: // 'text' or other

						response = data;

						break;

				}

				// Wait for next browser tick
				window.setTimeout( function () {

					if ( onLoad ) onLoad( response );

					scope.manager.itemEnd( url );

				}, 0 );

			} catch ( error ) {

				// Wait for next browser tick
				window.setTimeout( function () {

					if ( onError ) onError( error );

					scope.manager.itemError( url );

				}, 0 );

			}

		} else {

			var request = new XMLHttpRequest();
			request.open( 'GET', url, true );

			request.addEventListener( 'load', function ( event ) {

				var response = event.target.response;

				Cache.add( url, response );

				if ( this.status === 200 ) {

					if ( onLoad ) onLoad( response );

					scope.manager.itemEnd( url );

				} else if ( this.status === 0 ) {

					// Some browsers return HTTP Status 0 when using non-http protocol
					// e.g. 'file://' or 'data://'. Handle as success.

					console.warn( 'THREE.FileLoader: HTTP Status 0 received.' );

					if ( onLoad ) onLoad( response );

					scope.manager.itemEnd( url );

				} else {

					if ( onError ) onError( event );

					scope.manager.itemError( url );

				}

			}, false );

			if ( onProgress !== undefined ) {

				request.addEventListener( 'progress', function ( event ) {

					onProgress( event );

				}, false );

			}

			request.addEventListener( 'error', function ( event ) {

				if ( onError ) onError( event );

				scope.manager.itemError( url );

			}, false );

			if ( this.responseType !== undefined ) request.responseType = this.responseType;
			if ( this.withCredentials !== undefined ) request.withCredentials = this.withCredentials;

			if ( request.overrideMimeType ) request.overrideMimeType( this.mimeType !== undefined ? this.mimeType : 'text/plain' );

			request.send( null );

		}

		scope.manager.itemStart( url );

		return request;

	},

	setPath: function ( value ) {

		this.path = value;
		return this;

	},

	setResponseType: function ( value ) {

		this.responseType = value;
		return this;

	},

	setWithCredentials: function ( value ) {

		this.withCredentials = value;
		return this;

	},

	setMimeType: function ( value ) {

		this.mimeType = value;
		return this;

	}

} );






THREE.BabylonLoader = function ( manager ) {

	this.manager = ( manager !== undefined ) ? manager : THREE.DefaultLoadingManager;

};

THREE.BabylonLoader.prototype = {

	constructor: THREE.BabylonLoader,

	load: function ( url, onLoad, onProgress, onError ) {

		var scope = this;

		var loader = new FileLoader( scope.manager );
		loader.load( url, function ( text ) {

			onLoad( scope.parse( JSON.parse( text ) ) );

		}, onProgress, onError );

	},

	parse: function ( json ) {

		var materials = this.parseMaterials( json );
		var scene = this.parseObjects( json, materials );

		return scene;

	},

	parseMaterials: function ( json ) {

		var materials = {};

		for ( var i = 0, l = json.materials.length; i < l; i ++ ) {

			var data = json.materials[ i ];

			var material = new THREE.MeshPhongMaterial();
			material.name = data.name;
			material.color.fromArray( data.diffuse );
			material.emissive.fromArray( data.emissive );
			material.specular.fromArray( data.specular );
			material.shininess = data.specularPower;
			material.opacity = data.alpha;

			materials[ data.id ] = material;

		}

		if ( json.multiMaterials ) {

			for ( var i = 0, l = json.multiMaterials.length; i < l; i ++ ) {

				var data = json.multiMaterials[ i ];

				console.warn( 'THREE.BabylonLoader: Multi materials not yet supported.' );

				materials[ data.id ] = new THREE.MeshPhongMaterial();

			}

		}

		return materials;

	},

	parseGeometry: function ( json ) {

		var geometry = new THREE.BufferGeometry();

		// indices

		var indices = new Uint16Array( json.indices );

		geometry.setIndex( new THREE.BufferAttribute( indices, 1 ) );

		// positions

		var positions = new Float32Array( json.positions );

		for ( var j = 2, jl = positions.length; j < jl; j += 3 ) {

			positions[ j ] = - positions[ j ];

		}

		geometry.addAttribute( 'position', new THREE.BufferAttribute( positions, 3 ) );

		// normals

		if ( json.normals ) {

			var normals = new Float32Array( json.normals );

			for ( var j = 2, jl = normals.length; j < jl; j += 3 ) {

				normals[ j ] = - normals[ j ];

			}

			geometry.addAttribute( 'normal', new THREE.BufferAttribute( normals, 3 ) );

		}

		// uvs

		if ( json.uvs ) {

			var uvs = new Float32Array( json.uvs );

			geometry.addAttribute( 'uv', new THREE.BufferAttribute( uvs, 2 ) );

		}

		// offsets

		var subMeshes = json.subMeshes;

		if ( subMeshes ) {

			for ( var j = 0, jl = subMeshes.length; j < jl; j ++ ) {

				var subMesh = subMeshes[ j ];

				geometry.addGroup( subMesh.indexStart, subMesh.indexCount );

			}

		}

		return geometry;

	},

	parseObjects: function ( json, materials ) {

		var objects = {};
		var scene = new THREE.Scene();

		var cameras = json.cameras;

		for ( var i = 0, l = cameras.length; i < l; i ++ ) {

			var data = cameras[ i ];

			var camera = new THREE.PerspectiveCamera( ( data.fov / Math.PI ) * 180, 1.33, data.minZ, data.maxZ );

			camera.name = data.name;
			camera.position.fromArray( data.position );
			if ( data.rotation ) camera.rotation.fromArray( data.rotation );

			objects[ data.id ] = camera;

		}

		var lights = json.lights;

		for ( var i = 0, l = lights.length; i < l; i ++ ) {

			var data = lights[ i ];

			var light;

			switch ( data.type ) {

				case 0:
					light = new THREE.PointLight();
					break;

				case 1:
					light = new THREE.DirectionalLight();
					break;

				case 2:
					light = new THREE.SpotLight();
					break;

				case 3:
					light = new THREE.HemisphereLight();
					break;
			}

			light.name = data.name;
			if ( data.position ) light.position.set( data.position[ 0 ], data.position[ 1 ], - data.position[ 2 ] );
			light.color.fromArray( data.diffuse );
			if ( data.groundColor ) light.groundColor.fromArray( data.groundColor );
			if ( data.intensity ) light.intensity = data.intensity;

			objects[ data.id ] = light;

			scene.add( light );

		}

		var meshes = json.meshes;

		for ( var i = 0, l = meshes.length; i < l; i ++ ) {

			var data = meshes[ i ];

			var object;

			if ( data.indices ) {

				var geometry = this.parseGeometry( data );

				object = new THREE.Mesh( geometry, materials[ data.materialId ] );

			} else {

				object = new THREE.Group();

			}

			object.name = data.name;
			object.position.set( data.position[ 0 ], data.position[ 1 ], - data.position[ 2 ] );
			object.rotation.fromArray( data.rotation );
			if ( data.rotationQuaternion ) object.quaternion.fromArray( data.rotationQuaternion );
			object.scale.fromArray( data.scaling );
			// object.visible = data.isVisible;

			if ( data.parentId ) {

				objects[ data.parentId ].add( object );

			} else {

				scene.add( object );

			}

			objects[ data.id ] = object;

		}

		return scene;

	}

};

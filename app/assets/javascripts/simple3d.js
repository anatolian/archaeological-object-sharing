var simpleRender = function() {
  var scene = new THREE.Scene();
  var camera = new THREE.PerspectiveCamera( 75, window.innerWidth/window.innerHeight, 0.1, 1000 );

  var renderer = new THREE.WebGLRenderer();
  renderer.setSize( window.innerWidth, window.innerHeight );
  document.body.appendChild( renderer.domElement );

  var geometry = new THREE.BoxGeometry( 1, 1, 1 );
  var material = new THREE.MeshBasicMaterial( { color: 0x00ff00 } );
  var cube = new THREE.Mesh( geometry, material );
  scene.add( cube );

  camera.position.z = 5;

  var render = function () {
    requestAnimationFrame( render );

    cube.rotation.x += 0.1;
    cube.rotation.y += 0.1;

    renderer.render(scene, camera);
  };

  render();
}

var loadedRender = function(path) {
  if (!Detector.webgl) {
            Detector.addGetWebGLMessage();
        }
        var container;
        var camera, controls, scene, renderer;
        var lighting, ambient, keyLight, fillLight, backLight;
        var windowHalfX = window.innerWidth / 2;
        var windowHalfY = window.innerHeight / 2;
        init();
        animate();
        function init() {
            container = document.createElement('div');
            document.body.appendChild(container);
            /* Camera */
            camera = new THREE.PerspectiveCamera(45, window.innerWidth / window.innerHeight, 1, 1000);
            camera.position.z = 3;
            /* Scene */
            scene = new THREE.Scene();
            lighting = false;
            ambient = new THREE.AmbientLight(0xffffff, 1.0);
            scene.add(ambient);
            keyLight = new THREE.DirectionalLight(new THREE.Color('hsl(30, 100%, 75%)'), 1.0);
            keyLight.position.set(-100, 0, 100);
            fillLight = new THREE.DirectionalLight(new THREE.Color('hsl(240, 100%, 75%)'), 0.75);
            fillLight.position.set(100, 0, 100);
            backLight = new THREE.DirectionalLight(0xffffff, 1.0);
            backLight.position.set(100, 0, -100).normalize();
            // /* Model */
            // var mtlLoader = new THREE.MTLLoader();
            // // mtlLoader.setBaseUrl('/assets');
            // // mtlLoader.setPath('/assets');
            // mtlLoader.load(path, function (materials) {
            //     materials.preload();
            //     materials.materials.default.map.magFilter = THREE.NearestFilter;
            //     materials.materials.default.map.minFilter = THREE.LinearFilter;
            //     var objLoader = new THREE.OBJLoader();
            //     objLoader.setMaterials(materials);
            //     objLoader.setPath('/assets');
            //     objLoader.load('female-croupier-2013-03-26.obj', function (object) {
            //         scene.add(object);
            //     });
            // });

            // model
			var loader = new THREE.UTF8Loader();
				loader.load( path, function ( object ) {
					var end = Date.now();
					console.log( "hand", end - start, "ms" );
					var s = 350;
					object.scale.set( s, s, s );
					object.position.x = 125;
					object.position.y = -125;
					scene.add( object );
					object.traverse( function( node ) {
						node.castShadow = true;
						node.receiveShadow = true;
					} );
				}, { normalizeRGB: true } );
            /* Renderer */
            renderer = new THREE.WebGLRenderer();
            renderer.setPixelRatio(window.devicePixelRatio);
            renderer.setSize(window.innerWidth, window.innerHeight);
            renderer.setClearColor(new THREE.Color("hsl(0, 0%, 10%)"));
            container.appendChild(renderer.domElement);
            /* Controls */
            controls = new THREE.OrbitControls(camera, renderer.domElement);
            controls.enableDamping = true;
            controls.dampingFactor = 0.25;
            controls.enableZoom = false;
            /* Events */
            window.addEventListener('resize', onWindowResize, false);
            window.addEventListener('keydown', onKeyboardEvent, false);
        }
        function onWindowResize() {
            windowHalfX = window.innerWidth / 2;
            windowHalfY = window.innerHeight / 2;
            camera.aspect = window.innerWidth / window.innerHeight;
            camera.updateProjectionMatrix();
            renderer.setSize(window.innerWidth, window.innerHeight);
        }
        function onKeyboardEvent(e) {
            if (e.code === 'KeyL') {
                lighting = !lighting;
                if (lighting) {
                    ambient.intensity = 0.25;
                    scene.add(keyLight);
                    scene.add(fillLight);
                    scene.add(backLight);
                } else {
                    ambient.intensity = 1.0;
                    scene.remove(keyLight);
                    scene.remove(fillLight);
                    scene.remove(backLight);
                }
            }
        }
        function animate() {
            requestAnimationFrame(animate);
            controls.update();
            render();
        }
        function render() {
            renderer.render(scene, camera);
        }
}

var babylonRender = function(path) {
    var camera, controls, scene, renderer;
			init();
			function init() {
				camera = new THREE.PerspectiveCamera( 45, window.innerWidth / window.innerHeight, 1, 2000 );
				camera.position.z = 100;
				// controls = new THREE.TrackballControls( camera );
				// scene
				scene = new THREE.Scene();
				// texture
				var manager = new THREE.LoadingManager();
				manager.onProgress = function ( item, loaded, total ) {
					console.log( item, loaded, total );
				};
				var texture = new THREE.Texture();
				var material = new THREE.MeshBasicMaterial( { color: 'red' } );
				var onProgress = function ( xhr ) {
					if ( xhr.lengthComputable ) {
						var percentComplete = xhr.loaded / xhr.total * 100;
						console.log( Math.round(percentComplete, 2) + '% downloaded' );
					}
				};
				var onError = function ( xhr ) {
				};
				// model
				var loader = new THREE.BabylonLoader( manager );
				loader.load( 'http://localhost:3000/system/663ea64a9d98de76682c226fdf158ca96566bcff.babylon?1482087434', function ( babylonScene ) {
					babylonScene.traverse( function ( object ) {
						if ( object instanceof THREE.Mesh ) {
							object.material = new THREE.MeshPhongMaterial( {
								color: Math.random() * 0xffffff
							} );
						}
					} );
					scene = babylonScene;
					animate();
				}, onProgress, onError );
				//
				renderer = new THREE.WebGLRenderer();
				renderer.setPixelRatio( window.devicePixelRatio );
				renderer.setSize( window.innerWidth, window.innerHeight );
				document.body.appendChild( renderer.domElement );
				//
				window.addEventListener( 'resize', onWindowResize, false );
			}
			function onWindowResize() {
				camera.aspect = window.innerWidth / window.innerHeight;
				camera.updateProjectionMatrix();
				renderer.setSize( window.innerWidth, window.innerHeight );
				controls.handleResize();
			}
			//
			function animate() {
				requestAnimationFrame( animate );
				render();
			}
			function render() {
				controls.update();
				renderer.render( scene, camera );
			}
}


var vtkRender = function(path) {
    if ( ! Detector.webgl ) Detector.addGetWebGLMessage();
			var container, stats;
			var camera, controls, scene, renderer;
			var cross;
			init();
			animate();
			function init() {
				camera = new THREE.PerspectiveCamera( 60, window.innerWidth / window.innerHeight, 0.01, 1e10 );
				camera.position.z = 0.2;
				// controls = new THREE.TrackballControls( camera );
				// controls.rotateSpeed = 5.0;
				// controls.zoomSpeed = 5;
				// controls.panSpeed = 2;
				// controls.noZoom = false;
				// controls.noPan = false;
				// controls.staticMoving = true;
				// controls.dynamicDampingFactor = 0.3;

                
				scene = new THREE.Scene();
				scene.add( camera );
				// light
				var dirLight = new THREE.DirectionalLight( 0xffffff );
				dirLight.position.set( 200, 200, 1000 ).normalize();
				camera.add( dirLight );
				camera.add( dirLight.target );
				var material = new THREE.MeshLambertMaterial( { color: 0xffffff, side: THREE.DoubleSide } );
				var loader = new THREE.VTKLoader();
				loader.load( path, function ( geometry ) {
					geometry.center();
					geometry.computeVertexNormals();
					var mesh = new THREE.Mesh( geometry, material );
					mesh.position.set( - 0.075, 0.005, 0 );
					mesh.scale.multiplyScalar( 0.2 );
					scene.add( mesh );
				} );
				// var loader1 = new THREE.VTKLoader();
				// loader1.load( 'models/vtk/cube_ascii.vtp', function ( geometry ) {
				// 	geometry.computeVertexNormals();
				// 	geometry.center();
				// 	var material = new THREE.MeshLambertMaterial( { color: 0x00ff00, side: THREE.DoubleSide } );
				// 	var mesh = new THREE.Mesh( geometry, material );
				// 	mesh.position.set( - 0.025, 0, 0 );
				// 	mesh.scale.multiplyScalar( 0.01 );
				// 	scene.add( mesh );
				// } );
				// var loader2 = new THREE.VTKLoader();
				// loader2.load( 'models/vtk/cube_binary.vtp', function ( geometry ) {
				// 	geometry.computeVertexNormals();
				// 	geometry.center();
				// 	var material = new THREE.MeshLambertMaterial( { color: 0x0000ff, side: THREE.DoubleSide } );
				// 	var mesh = new THREE.Mesh( geometry, material );
				// 	mesh.position.set( 0.025, 0, 0 );
				// 	mesh.scale.multiplyScalar( 0.01 );
				// 	scene.add( mesh );
				// } );
				// var loader3 = new THREE.VTKLoader();
				// loader3.load( 'models/vtk/cube_no_compression.vtp', function ( geometry ) {
				// 	geometry.computeVertexNormals();
				// 	geometry.center();
				// 	var material = new THREE.MeshLambertMaterial( { color: 0xff0000, side: THREE.DoubleSide } );
				// 	var mesh = new THREE.Mesh( geometry, material );
				// 	mesh.position.set( 0.075, 0, 0 );
				// 	mesh.scale.multiplyScalar( 0.01 );
				// 	scene.add( mesh );
				// } );
				// renderer
				renderer = new THREE.WebGLRenderer( { antialias: false } );
				renderer.setPixelRatio( window.devicePixelRatio );
				renderer.setSize( window.innerWidth/2, window.innerHeight/2 );
                container = document.createElement( 'div' );
                container.style.margin = "auto 25%";
				document.body.appendChild( container );
				container.appendChild( renderer.domElement );

                controls = new THREE.OrbitControls(camera, renderer.domElement);
                controls.enableDamping = true;
                controls.dampingFactor = 0.25;
                controls.enableZoom = false;
				//stats = new Stats();
				//container.appendChild( stats.dom );
				//
				window.addEventListener( 'resize', onWindowResize, false );
			}
			function onWindowResize() {
				camera.aspect = window.innerWidth / window.innerHeight;
				camera.updateProjectionMatrix();
				renderer.setSize( window.innerWidth, window.innerHeight );
				//controls.handleResize();
			}
			function animate() {
				requestAnimationFrame( animate );
				controls.update();
				renderer.render( scene, camera );
				//stats.update();
			}

}
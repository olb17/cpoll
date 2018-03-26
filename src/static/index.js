// pull in desired CSS/SASS files
require( '../../node_modules/bulma/bulma.sass' );
require( '../../node_modules/normalize.css/normalize.css' );
require( './styles/main.scss' );

import '@fortawesome/fontawesome'
import '@fortawesome/fontawesome-free-solid'
import '@fortawesome/fontawesome-free-brands'

// inject bundled Elm app into div#main
var Elm = require( '../elm/Main' );
Elm.Main.embed( document.getElementById( 'main' ) );

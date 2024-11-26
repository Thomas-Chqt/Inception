<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the website, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress_db' );

/** Database username */
define( 'DB_USER', 'wordpress_user' );

/** Database password */
define( 'DB_PASSWORD', 'wordpress_password' );

/** Database hostname */
define( 'DB_HOST', 'mariadb:3360' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '*<%+i0xiZ^+GAE)-9FB:xwWTF[rdz&1GA(MkU%q*HMHi%3LzF7+at:~@-~,/<Cp9');
define('SECURE_AUTH_KEY',  'R1gEJRhM(n;O61?9`$GOGyC)I(qWA||u2ECGC7X7WeHzG?<_CfB1cF|9nJzmrA*@');
define('LOGGED_IN_KEY',    'i&w5!S+sGopVE9LI[FH|8e_fHjlScyS}G5lWq%qqOOY?|_<|k%;HOXL)H:&hiac|');
define('NONCE_KEY',        'rbj>YrN_1OOt>[G#-Ds~-g( #.Z ~Y!?<k+w%84w6w}B+J #A 7f.xxRR>-@P0:J');
define('AUTH_SALT',        'q~f!uu03GwP)6mU.3vSW*)Ib<4uRF*S$-Bg`!PNJohqx2Q_GN<jY^0|l|`l$thiZ');
define('SECURE_AUTH_SALT', 'Z1eDz*}b.;C+.>-<?@PAoK=*=5cq3@%qK-GS)3 v<IB/p?GrSIZM&+A0-rL;OAgE');
define('LOGGED_IN_SALT',   '-v)%>5pqfXbxXsF$pF;c]wyM0$#tqTGW~A7]&o2i:gd+G+Qbp{!$>VRoFr:1hO}F');
define('NONCE_SALT',       '_jBsQ[1&yFGM9)vkl[kyEV0MpB!6gWHd*Jx1~yOeFTTgw+e/t]DipcctNON(CT`a');

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 *
 * At the installation time, database tables are created with the specified prefix.
 * Changing this value after WordPress is installed will make your site think
 * it has not been installed.
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/#table-prefix
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://developer.wordpress.org/advanced-administration/debug/debug-wordpress/
 */
define( 'WP_DEBUG', true );

/* Add any custom values between this line and the "stop editing" line. */

define( 'WP_DEBUG_LOG', true );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';

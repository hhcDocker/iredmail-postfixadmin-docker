<?php
$CONF['configured'] = true;

$CONF['setup_password'] = '33e27311aebd8213d00aab8bcc813d37:f7f1cf0072a8576c3f91cbca444822d420a77d07';

$CONF['database_type'] = 'mysqli';
$CONF['database_host'] = 'localhost';
$CONF['database_user'] = 'vmailadmin';
$CONF['database_password'] = 'TEMP_VMAIL_DB_ADMIN_PASSWD';
$CONF['database_name'] = 'vmail';

$CONF['encrypt'] = 'md5crypt';

// Default Aliases
// The default aliases that need to be created for all domains.
// You can specify the target address in two ways:
// a) a full mail address
// b) only a localpart ('postmaster' => 'admin') - the alias target will point to the same domain
$CONF['default_aliases'] = array (
    'abuse' => 'abuse@TEMP_DOMAIN',
    'hostmaster' => 'hostmaster@TEMP_DOMAIN',
    'postmaster' => 'postmaster@TEMP_DOMAIN',
    'webmaster' => 'webmaster@TEMP_DOMAIN'
);

$CONF['vacation_domain'] = 'autoreply.TEMP_DOMAIN';

$CONF['footer_text'] = 'Return to TEMP_DOMAIN';
$CONF['footer_link'] = 'http://TEMP_DOMAIN';

// you can assign special colors to some domains. To do this,
// - add the domain to show_custom_domains
// - add the corresponding color to show_custom_colors
$CONF['show_custom_domains']=array('TEMP_DOMAIN');
$CONF['show_custom_colors']=array("lightgreen");


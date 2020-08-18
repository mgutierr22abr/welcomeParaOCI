#!/bin/bash

echo '########################################################'
echo 'Creando SCHEMA user & Workspace'

sqlplus admin/${PW}@${NOMBRE}_low <<EOF
   create user usage identified by ${PW};
   grant connect, resource, dwrole, unlimited tablespace to usage;
BEGIN
    APEX_INSTANCE_ADMIN.ADD_WORKSPACE ( p_workspace  => 'USAGE', p_primary_schema => 'USAGE' );
END;
/
EOF
echo '########################################################'
echo 'Importando APEX app & Creando final user'
sqlplus usage/${PW}@${NOMBRE}_low <<EOF
declare
l_workspace_id number;
begin
l_workspace_id := apex_util.find_security_group_id (p_workspace => 'USAGE');
apex_util.set_security_group_id (p_security_group_id => l_workspace_id);
APEX_UTIL.PAUSE(2);
end;
/
@apex_demo_app/usage.demo.apex.sql

BEGIN
    APEX_UTIL.CREATE_USER(
        p_user_name                     => 'USAGE2',
        p_first_name                    => 'USAGE',
        p_last_name                     => 'USAGE',
        p_description                   => 'USAGE...',
        p_email_address                 => 'USAGE@USAGE.com',
        p_web_password                  => '$PW',
        p_developer_privs               => 'ADMIN:CREATE:DATA_LOADER:EDIT:HELP:MONITOR:SQL',
        p_default_schema                => 'USAGE',
        p_allow_access_to_schemas       => 'USAGE',
        p_change_password_on_first_use  => 'N',
        p_attribute_01                  => '123 456 7890');
END;
/
EOF
echo '########################################################'
echo 'Loop to load files'
python3 --version
while [ true ]; do
	python3 usage2adw.py -ip -du USAGE -dp $PW -dn ${NOMBRE}_low
	echo '########################################################'
	echo fecha $(date) ......
	sleep 3000
done

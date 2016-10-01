#!/bin/sh
######## SET
LANG=C
LC_ALL=C
STARTDATE=$(/bin/date '+%Y-%m-%d -- %T')
MKDIR=$(which mkdir)
#PWD=$(which pwd)
OPENSSL=$(which openssl)
CA_DIR="CA"
######## SCRIPTS
[ -x ${CA_DIR} ] || ${MKDIR} ${CA_DIR}
cd ${CA_DIR}
${OPENSSL} req -sha1 -newkey rsa:2048 -days 730 -nodes -keyout client-${1}-key.pem > client-${1}-req.pem
${OPENSSL} rsa -in client-${1}-key.pem -out client-${1}-key.pem
${OPENSSL} x509 -sha1 -req -in client-${1}-req.pem -days 730 -CA ca-cert.pem -CAkey ca-key.pem -set_serial 01 > client-${1}-cert.pem
#EOF

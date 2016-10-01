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
${OPENSSL} genrsa 2048 > ca-key.pem
${OPENSSL} req -sha1 -new -x509 -nodes -days 3650 -key ca-key.pem > ca-cert.pem
${OPENSSL} req -sha1 -newkey rsa:2048 -days 730 -nodes -keyout server-key.pem > server-req.pem
${OPENSSL} rsa -in server-key.pem -out server-key.pem
${OPENSSL} x509 -sha1 -req -in server-req.pem -days 730 -CA ca-cert.pem -CAkey ca-key.pem -set_serial 01 > server-cert.pem
#EOF

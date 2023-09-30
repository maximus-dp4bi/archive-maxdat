#!/bin/bash

. ~/.bash_profile

#Complete the environment - Specific to AMP only
#---------------------------
export LOG_LIFE_DAYS=90
export MIN_LOG_SIZE="4k"
export MAXDAT_EXPORT_INBOUND_DIR=$MOTS_ROOT/files/maxdat/Inbound/
export AMP_v2_TEMPLATE_INBOUND_DIR=$MOTS_ROOT/files/template/Inbound/v2/
export AMP_v1_TEMPLATE_INBOUND_DIR=$MOTS_ROOT/files/template/Inbound/
export MOTS_DELTEK_INBOUND_DIR=$MOTS_ROOT/files/deltek/Inbound
export AMP_METRICS_XML_INBOUND_DIR=$MOTS_ROOT/files/template/Inbound/
export AMP_METRICS_XML_EMAIL_DIR=$MOTS_ROOT/files/template/Email
#--------------------------



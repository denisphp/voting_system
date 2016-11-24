#!/bin/bash

description()
{
    echo -en "\033[36m"  ## blue
    cat << EOF

Script runs ansible provisioning
EOF
    echo -en "\033[0m"  ## reset color
    usage
}

usage()
{
    cat << EOF

Usage: ./deploy.sh inventory [options]

   inventory        Required! Path to ansible inventory file
                        (you can use absolute path to inventory file)

OPTIONS:
   -d, --debug                          Debug mode: only output command without running it
   -f, --force                          Force update (ignore lock file).
   -h, --help                           Show this message.
   -k, --amazon-key=KEY.pem             If you use this option, script will set the right permissions for amazon key.
   -p, --playbook=PLAYBOOK_NAME.yml     Ansible playbook file. Like: playbook.yml
                                            (default use --inventory param, like 'INVENTORY_FILE.yml').
   -v, --verbose                        Ansible verbose mode (-vvvv to enable connection debugging).

EOF
}

die () {
    echo -en "\033[36m"  ## blue
    usage
    echo -en "\033[31m"  ## red
    cat << EOF
$@

EOF
    echo -en "\033[0m"  ## reset color
    exit 1
}

[ "$#" -ne 0 ] || die "inventory param required"

#environment
DEBUG=
FORCE=
VERBOSE=
PLAYBOOK=
AMAZON_KEY=

INVENTORY="$1"
shift

if [[ "$INVENTORY" = "-h" || "$INVENTORY" = "--help"  || "$INVENTORY" = "-help" ]]; then
  description
  exit
fi

while [ -n "$1" ]; do
        # Copy so we can modify it (can't modify $1)
        OPT="$1"
        # Detect argument termination
        if [ x"$OPT" = x"--" ]; then
                shift
                for OPT ; do
                        REMAINS="$REMAINS \"$OPT\""
                done
                break
        fi
        # Parse current opt
        while [ x"$OPT" != x"-" ] ; do
                case "$OPT" in
                        -d* | --debug )
                                DEBUG=1
                                ;;
                        -f* | --force )
                                FORCE=" force_update=true"
                                ;;
                        -h | --help )
                                description
                                exit
                                ;;
                        # Handle --flag=value opts like this
                        -k=* | --amazon-key=* )
                                AMAZON_KEY="${OPT#*=}"
                                shift
                                ;;
                        # and --flag value opts like this
                        -k* | --amazon-key )
                                AMAZON_KEY="$2"
                                shift
                                ;;
                        -p=* | --playbook=* )
                                PLAYBOOK="${OPT#*=}"
                                shift
                                ;;
                        -p* | --playbook )
                                PLAYBOOK="$2"
                                shift
                                ;;
                        -v* | --verbose )
                                VERBOSE=" -vvvv"
                                ;;
                        # Anything unknown is recorded for later
                        * )
                                REMAINS="$REMAINS \"$OPT\""
                                break
                                ;;
                esac
                # Check for multiple short options
                # NOTICE: be sure to update this pattern to match valid options
                NEXTOPT="${OPT#-[cfr]}" # try removing single short opt
                if [ x"$OPT" != x"$NEXTOPT" ] ; then
                        OPT="-$NEXTOPT"  # multiple short opts, keep going
                else
                        break  # long form, exit inner loop
                fi
        done
        # Done with that param. move to next
        shift
done
# Set the non-parameters back into the positional parameters ($1 $2 ..)
eval set -- $REMAINS

if [ -z "$PLAYBOOK" ]; then
  PLAYBOOK=$INVENTORY".yml"
fi

if [[ -n "$AMAZON_KEY" && "$DEBUG" != 1 ]]; then
  # Set only read for amazon key
  sudo chmod 0400 $AMAZON_KEY
fi

if [ "$DEBUG" == 1 ]; then
  echo "ansible-playbook -i $INVENTORY $PLAYBOOK$VERBOSE -T 120 -c ssh -e \"pipelining=True host_key_checking=False$FORCE\""
else
  ansible-playbook -i $INVENTORY $PLAYBOOK$VERBOSE -T 120 -c ssh -e "pipelining=True host_key_checking=False$FORCE"
fi
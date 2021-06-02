#!/usr/bin/env bash

# cd to script directory
set -eEu -o pipefail
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR
unset DIR

# download required packages
rm -rf ./packages
mkdir -p ./packages
python3 -m pip download -d ./packages doccano

doccano_package_path=( "./packages/doccano-*.tar.gz" )
doccano_package=$(sh -c 'printf $0' ${doccano_package_path[0]})

# extract files
tar -zxf $doccano_package -C .
# reads: doccano-$version.tar.gz
doccano_base=$(basename -- "$doccano_package")
# reads: doccano-$version
doccano_dir="${doccano_base%%.tar.gz}"

# install requests
python3 -m pip install requests

# create offline directory
doccano_dist_dir="${doccano_dir}/backend/client/dist"
mkdir -p "${doccano_dist_dir}/static/offline"
# patch assets for offline use
python3 ../offline_patcher.py "${doccano_dist_dir}" "${doccano_dist_dir}/static/offline" "/static/offline"

# compress patched doccano package
tar -zcvf "$doccano_base" "$doccano_dir"
# backup old doccano package
mv "$doccano_package" "$doccano_base.bak"
# move patched doccano package to packages directory
mv "$doccano_base" "./packages/$doccano_base"

# cleanup
rm -rf "$doccano_dir"
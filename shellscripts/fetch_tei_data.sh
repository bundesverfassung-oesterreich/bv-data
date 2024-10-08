#!/bin/bash
# # def vars
temp_path="./tmp_tmp/"
dump_path="${temp_path}main.zip"
target_editions_path="./data/editions/"
zip_file="${temp_path}main.zip"
fetched_transkribus_export_editions_path="${temp_path}bv-transkribus-export-main/editions_source/"
fetched_working_data_path="${temp_path}bv-working-data-main/data/editions/"
fetched_commentary_data_path="${temp_path}bv-working-data-main/data/commentaries/"
target_editions_path="./data/editions/"
target_commentaries_path="./data/commentaries/"
bv_transkribus_export_url="https://github.com/bundesverfassung-oesterreich/bv-transkribus-export/archive/refs/heads/main.zip"
bv_working_data_url="https://github.com/bundesverfassung-oesterreich/bv-working-data/archive/refs/heads/main.zip"

function fetch_data_and_copy() {
    url=$1
    editions_folder=$2
    rm -rf $temp_path
    mkdir $temp_path
    if [ ! -d "$target_editions_path" ]; then mkdir -p "$target_editions_path"; fi
    wget $url -O $dump_path
    unzip $dump_path -d $temp_path
    find $editions_folder -name "*.xml" -exec cp "{}" "$target_editions_path" \;
}
# get frech copy of transkribus_export
fetch_data_and_copy $bv_transkribus_export_url $fetched_transkribus_export_editions_path
# overwrite with data from working_data
fetch_data_and_copy $bv_working_data_url $fetched_working_data_path
# since working data is already in tmp_tmp, copy the commentaries too
find $fetched_commentary_data_path -name "*.xml" -exec cp "{}" "$target_commentaries_path" \;
rm -rf $temp_path
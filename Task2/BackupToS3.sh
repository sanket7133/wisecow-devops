#Write a script to automate the backup of a specified directory to a remote server or a cloud storage solution. 
#The script should provide a report on the success or failure of the backup operation.

#!/bin/bash

source_dir="/path/to/your/data"
bucket_name="Linux_backup"
backup_prefix="backups"

backup_file="${source_dir}.tar.gz"

function backup {

  tar czf "$backup_file" "$source_dir"


  aws s3 cp "$backup_file" s3://$bucket_name/$backup_prefix/$backup_file

   rm "$backup_file"


  if [ $? -eq 0 ]; then
    echo "Backup successful!"
  else
    echo "Backup failed!"
  fi
}

backup

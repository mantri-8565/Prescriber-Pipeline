############################################################
# Developed By: Sourav Mantri                              #
# Developed Date: 2023-05-06                               #
# Script NAME:                                             #
# PURPOSE: Copy input vendor files from local to AWS S3.     #
############################################################

# Declare a variable to hold the unix script name.
JOBNAME="copy_files_to_s3.ksh"

#Declare a variable to hold the current date
date=$(date '+%Y-%m-%d_%H:%M:%S')
bucket_subdir_name=$(date '+%Y-%m-%d-%H-%M-%S')

#Define a Log File where logs would be generated
LOGFILE="/home/${USER}/projects/PrescPipeline/src/main/python/logs/${JOBNAME}_${date}.log"

###########################################################################
### COMMENTS: From this point on, all standard output and standard error will
###           be logged in the log file.
###########################################################################
{  # <--- Start of the log file.
echo "${JOBNAME} Started...: $(date)"

LOCAL_OUTPUT_PATH="/home/${USER}/projects/PrescPipeline/src/main/python/output"
LOCAL_CITY_DIR=${LOCAL_OUTPUT_PATH}/dimension_city
LOCAL_FACT_DIR=${LOCAL_OUTPUT_PATH}/presc

# Push City  and Fact files to s3.
for file in ${LOCAL_CITY_DIR}/*.*
do
  aws s3 --profile myprofile cp ${file} "s3://prescpipeline/dimension_city/$bucket_subdir_name/"
done
echo "City File $file is pushed to S3."

for file in ${LOCAL_FACT_DIR}/*.*
do
  aws s3 --profile myprofile cp ${file} "s3://prescpipeline/presc/$bucket_subdir_name/"
done
echo "Presc file $file is pushed to s3."

echo "The ${JOBNAME} is Completed...: $(date)"

} > ${LOGFILE} 2>&1  # <--- End of program and end of log.

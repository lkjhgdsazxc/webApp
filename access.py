import boto3

session = boto3.Session()
credentials = session.get_credentials()

# Credentials are refreshable, so accessing your access key / secret key
# separately can lead to a race condition. Use this to get an actual matched
# set.
#credentials = credentials.get_frozen_credentials()
access_key = credentials.access_key
secret_key = credentials.secret_key
session_token = credentials.token

print(access_key)



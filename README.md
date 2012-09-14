# s3.sh

Bash functions for Amazon S3. (Not complete, just scratching my itch)

# API

## s3\_sign\_url ${awsKey} ${awsSecret} ${bucket} ${path} ${expires:-`date -v+60S +%s`}

Returns an url suitable for making a GET request to a private s3 object.

Dependencies:

* date
* openssl

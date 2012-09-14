# s3.sh

Bash functions for Amazon S3. (Not complete, just scratching my itch)

# API

```bash
s3_sign_url ${awsKey} ${awsSecret} ${bucket} ${path} ${expires:-`date -v+60S +%s`}
```

Returns an url suitable for making a GET request to a private s3 object.

Dependencies:

* date, if ${expires} parameter is not provided
* openssl

# s3.sh

Bash functions for Amazon S3. (Not complete, just scratching my itch)

# API

```bash
s3_url ${bucket} ${path}
```

Returns a url for the given ${bucket} and ${path}.

```bash
s3_signed_url ${httpMethod} ${bucket} ${path} ${awsKey} ${awsSecret} ${expires:-`date -v+60S +%s`}
```

Returns a signed url, suitable for making requests to a private s3 object.

Dependencies:

* date, if ${expires} parameter is not provided
* openssl

# s3.sh

Bash functions for Amazon S3. (Not complete, just scratching my itch)

# API

```bash
s3_url ${bucket} ${path}
```

Returns a url for the given ${bucket} and ${path}.

```bash
s3_signed_url ${httpMethod} ${bucket} ${path} ${awsKey} ${awsSecret} ${expires:-$((`date +%s`+60))}
```

Returns a signed url, suitable for making requests to a private s3 object.

```bash
role_name="my_role"
temporary_creds=$(curl -s http://169.254.169.254/latest/meta-data/iam/security-credentials/${role_name})
awsKey=$(echo ${temporary_creds} | jq -r '.AccessKeyId')
awsSecret=$(echo ${temporary_creds} | jq -r '.SecretAccessKey')
awsToken=$(echo ${temporary_creds} | jq -r '.Token'))
s3_signed_url ${httpMethod} ${bucket} ${path} ${awsKey} ${awsSecret} ${expires:-$((`date +%s`+60))} ${awsToken}
```

Returns a signed url by credentials provided by an IAM role

Dependencies:

* date, if ${expires} parameter is not provided
* openssl

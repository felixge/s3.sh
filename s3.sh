# send patches to: https://github.com/felixge/s3.sh

s3_sign_url() {
  local awsKey=${1}
  local awsSecret=${2}
  local bucket=${3}
  local path=${4}
  # Unix epoch number, defaults to 60 seconds in the future
  local expires=${5:-`date -v+60S +%s`}

  local stringToSign="GET\n\n\n${expires}\n/${bucket}/${path}"

  local base64Signature=`echo -en "${stringToSign}" \
    | openssl dgst -sha1 -binary -hmac ${awsSecret} \
    | openssl base64`

  # Escape all base64 special characters ('+', '=', '\') for url
  local escapedSignature=${base64Signature}
  escapedSignature=${escapedSignature//+/%2b}
  escapedSignature=${escapedSignature//\//%2f}
  escapedSignature=${escapedSignature//=/%3d}

  local query="Expires=${expires}&AWSAccessKeyId=${awsKey}&Signature=${escapedSignature}"
  local url="http://s3.amazonaws.com/${bucket}/${path}?${query}"

  echo ${url}
}

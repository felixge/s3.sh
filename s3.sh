# send patches to: https://github.com/felixge/s3.sh

s3_url() {
  local bucket=${1}
  local path=${2}
  local url="https://s3.amazonaws.com/${bucket}/${path}"

  echo ${url}
}

s3_signed_url() {
  local httpMethod=${1}
  local bucket=${2}
  local path=${3}
  local awsKey=${4}
  local awsSecret=${5}
  # Unix epoch number, defaults to 60 seconds in the future
  local expires=${6:-$((`date +%s`+60))}

  local stringToSign="${httpMethod}\n\n\n${expires}\n/${bucket}/${path}"

  local base64Signature=`echo -en "${stringToSign}" \
    | openssl dgst -sha1 -binary -hmac ${awsSecret} \
    | openssl base64`

  local escapedSignature=`_s3_urlencode ${base64Signature}`
  local escapedAwsKey=`_s3_urlencode ${awsKey}`

  local query="Expires=${expires}&AWSAccessKeyId=${escapedAwsKey}&Signature=${escapedSignature}"
  local url="`s3_url ${bucket} ${path}`?${query}"

  echo ${url}
}

# from: http://ethertubes.com/bash-snippet-url-encoding/
_s3_urlencode () {
  local tab="`echo -en "\x9"`"
  local i="$@"

  i=${i//%/%25}  ; i=${i//' '/%20} ; i=${i//$tab/%09}
  i=${i//!/%21}  ; i=${i//\"/%22}  ; i=${i//#/%23}
  i=${i//\$/%24} ; i=${i//\&/%26}  ; i=${i//\'/%27}
  i=${i//(/%28}  ; i=${i//)/%29}   ; i=${i//\*/%2a}
  i=${i//+/%2b}  ; i=${i//,/%2c}   ; i=${i//-/%2d}
  i=${i//\./%2e} ; i=${i//\//%2f}  ; i=${i//:/%3a}
  i=${i//;/%3b}  ; i=${i//</%3c}   ; i=${i//=/%3d}
  i=${i//>/%3e}  ; i=${i//\?/%3f}  ; i=${i//@/%40}
  i=${i//\[/%5b} ; i=${i//\\/%5c}  ; i=${i//\]/%5d}
  i=${i//\^/%5e} ; i=${i//_/%5f}   ; i=${i//\`/%60}
  i=${i//\{/%7b} ; i=${i//|/%7c}   ; i=${i//\}/%7d}
  i=${i//\~/%7e}
  echo "$i"
}

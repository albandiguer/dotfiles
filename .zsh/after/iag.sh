

do-oven-dev () {
  docker run -it --rm \
    -e PASS=${PASS} \
    -e USER=${USER} \
    -e http_proxy=${PROXY} \
    -e https_proxy=${PROXY} \
    -e no_proxy=127.0.0.1,localhost,.auiag.corp,.iag.com.au \
    -e HTTP_PROXY=${PROXY} \
    -e HTTPS_PROXY=${PROXY} \
    -v ${HOME}/dev/oven.cfg:/app/oven.cfg \
    -v ${HOME}/dev/cred-files:/cred-files swrepos.auiag.corp/cloud-foundations/oven:latest \
    -c /app/oven.cfg \
    -u ${USER} \
    -p ${PASS} \
    -o /cred-files/dev
}

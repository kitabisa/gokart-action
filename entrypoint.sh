#!/usr/bin/env bash

set -e

if [[ ! -f "${INPUT_DIRECTORY}/go.mod" ]] || [[ $(find "${INPUT_DIRECTORY}" -name "*.go" -type f -printf "." | wc -c) == "0" ]]; then
	echo "There's no Go module inside and/or it's not Go project. No need to run analysis."
	exit 1
fi

CMD="/go/bin/gokart scan ${INPUT_DIRECTORY}"
CMD+=" -s -o ${INPUT_OUTPUT}"
[[ ! -z ${INPUT_INPUT} ]] && CMD+=" -i ${INPUT_INPUT}"
[[ ! -z ${INPUT_GLOBALSTAINTED} ]] && CMD+=" -g"
[[ ! -z ${INPUT_REMOTEMODULE} ]] && CMD+=" -r ${INPUT_REMOTEMODULE}"
[[ ! -z ${INPUT_DEBUG} ]] && CMD+=" -d"
[[ ! -z ${INPUT_VERBOSE} ]] && CMD+=" -v"

eval "${CMD}"

if [[ ! -f "${INPUT_OUTPUT}" ]]; then
	echo "No results. ¯\_(ツ)_/¯"
	exit 1
fi

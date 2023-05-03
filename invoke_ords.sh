#!/bin/bash
# SPDX-License-Identifier: Apache-2.0
#
# Copyright 2023 Andres Almiray
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

echo "::group::🤖 Invoke ORDS"

if [ -z "${ORDS_COMMAND}" ]; then
    ORDS_COMMAND="none"
fi

if [ "${ORDS_COMMAND}" == "none" ]; then
    echo "✋ Skipping"
    echo "::endgroup::"
    exit 0
fi

ORDSDIR="${PWD}/.ords"
ORDS_HOME="${ORDSDIR}/ords-${VERSION}"

CMD="${ORDS_HOME}/bin/ords"

if [ -n "${ORDS_CONFIG}" ]; then
    CMD="${CMD} --config ${ORDS_CONFIG}"
fi

CMD="${CMD} ${ORDS_COMMAND}"

if [ -n "${ORDS_ARGUMENTS}" ]; then
    CMD="${CMD} ${ORDS_ARGUMENTS}"
fi

if [ "${ORDS_COMMAND}" == "serve" ]; then
    CMD="${CMD} &"
fi

eval "${CMD}"

echo "::endgroup::"

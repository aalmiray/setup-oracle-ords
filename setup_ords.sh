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

echo "::group::🔍 Check ORDS"

ORDSDIR="${PWD}/.ords"
ORDS_HOME="${ORDSDIR}/ords-${VERSION}"

if [ -d "${ORDS_HOME}" ]; then
    echo "✅ ORDS ${VERSION} already setup"
    export ORDS_HOME
    echo "ORDS_HOME=${ORDS_HOME}" >> $GITHUB_ENV
    echo "${ORDS_HOME}/bin" >> $GITHUB_PATH
    echo "::endgroup::"
    exit 0
else
    echo "☑️ ORDS ${VERSION} not available at ${ORDS_HOME}"
fi
echo "::endgroup::"

echo "::group::📦 Download ORDS"
# download
java "${GITHUB_ACTION_PATH}/get_ords.java" ${VERSION}

# extract
PWD=$(pwd)
export ORDS_HOME
unzip -qo -d "${ORDS_HOME}" "${ORDSDIR}/ords.zip"

echo "ORDS_HOME=${ORDS_HOME}" >> $GITHUB_ENV

# eval version
CMD="${ORDS_HOME}/bin/ords --version"
eval "${CMD}"

# export
echo "${ORDS_HOME}/bin" >> $GITHUB_PATH

echo "::endgroup::"

# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

cmake_minimum_required(VERSION 3.18)
get_filename_component(REPOSITORY_ROOT "../../../" ABSOLUTE)
list(APPEND CMAKE_MODULE_PATH "${REPOSITORY_ROOT}/c/cmake_modules/")
include(AdbcDefines)
include(BuildUtils)

project(adbc_driver_sqlite
        VERSION "${ADBC_BASE_VERSION}"
        LANGUAGES CXX)
include(CTest)
find_package(PkgConfig)

find_package(SQLite3 REQUIRED)

add_arrow_lib(adbc_driver_sqlite
              SOURCES
              sqlite.c
              statement_reader.c
              utils.c
              OUTPUTS
              ADBC_LIBRARIES
              SHARED_LINK_FLAGS
              ${ADBC_LINK_FLAGS}
              SHARED_LINK_LIBS
              SQLite::SQLite3
              nanoarrow
              STATIC_LINK_LIBS
              SQLite::SQLite3
              nanoarrow
              ${LIBPQ_STATIC_LIBRARIES})
include_directories(SYSTEM ${REPOSITORY_ROOT})
include_directories(SYSTEM ${REPOSITORY_ROOT}/c/)
include_directories(SYSTEM ${REPOSITORY_ROOT}/c/vendor/nanoarrow/)
foreach(LIB_TARGET ${ADBC_LIBRARIES})
  target_compile_definitions(${LIB_TARGET} PRIVATE ADBC_EXPORTING)
endforeach()

if(ADBC_TEST_LINKAGE STREQUAL "shared")
  set(TEST_LINK_LIBS adbc_driver_sqlite_shared)
else()
  set(TEST_LINK_LIBS adbc_driver_sqlite_static)
endif()

if(ADBC_BUILD_TESTS)
  add_test_case(driver_sqlite_test
                PREFIX
                adbc
                SOURCES
                sqlite_test.cc
                ../../validation/adbc_validation.cc
                ../../validation/adbc_validation_util.cc
                EXTRA_LINK_LIBS
                nanoarrow
                ${TEST_LINK_LIBS})
  target_compile_features(adbc-driver-sqlite-test PRIVATE cxx_std_17)
  adbc_configure_target(adbc-driver-sqlite-test)
endif()

validate_config()
config_summary_message()

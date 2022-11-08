vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO tricerat/g3log
    REF c6bd2453f8e1850e618980c2f0c6f37c0ac43f0d # tricerat/g3log/screwdrivers-7.4.0 on 11.8.2022
    SHA512 D7FDADCAE2FB9A4994CC18A1A7584B31C05E2B1A907360FE0B89DD37134FDD3CDC90244F4921225C7408B7F20F500805696C1682E23CF9819E1848BEC410D52B
    HEAD_REF master
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" G3_SHARED_LIB)
string(COMPARE EQUAL "${VCPKG_CRT_LINKAGE}" "dynamic" G3_SHARED_RUNTIME)

# https://github.com/KjellKod/g3log#prerequisites
set(VERSION "1.3.4")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DG3_SHARED_LIB=${G3_SHARED_LIB} # Options.cmake
        -DG3_SHARED_RUNTIME=${G3_SHARED_RUNTIME} # Options.cmake
        -DADD_FATAL_EXAMPLE=OFF
        -DADD_G3LOG_BENCH_PERFORMANCE=OFF
        -DADD_G3LOG_UNIT_TEST=OFF
        -DVERSION=${VERSION}
        -DUSE_DYNAMIC_LOGGING_LEVELS=ON
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/g3log)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# Handle copyright
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)

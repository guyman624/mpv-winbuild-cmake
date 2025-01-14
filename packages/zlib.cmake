ExternalProject_Add(zlib
    GIT_REPOSITORY https://github.com/zlib-ng/zlib-ng.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    UPDATE_COMMAND ""
    GIT_REMOTE_NAME origin
    GIT_TAG develop
    CONFIGURE_COMMAND ${EXEC} cmake -H<SOURCE_DIR> -B<BINARY_DIR>
        -G Ninja
        -DCMAKE_BUILD_TYPE=Release
        -DCMAKE_INSTALL_PREFIX=${MINGW_INSTALL_PREFIX}
        -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE}
        -DINSTALL_PKGCONFIG_DIR=${MINGW_INSTALL_PREFIX}/lib/pkgconfig
        -DSKIP_INSTALL_LIBRARIES=ON
        -DBUILD_SHARED_LIBS=OFF
        -DZLIB_COMPAT=ON
        -DZLIB_ENABLE_TESTS=OFF
        -DZLIBNG_ENABLE_TESTS=OFF
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
            COMMAND ${CMAKE_COMMAND} -E copy <BINARY_DIR>/libz.a ${MINGW_INSTALL_PREFIX}/lib/libz.a
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(zlib)
cleanup(zlib install)

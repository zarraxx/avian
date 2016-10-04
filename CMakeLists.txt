# NOTE that this CMake file doesn't current build all of avian.
# It only builds what's required for example/kaleidoscope.

cmake_minimum_required(VERSION 2.6)
project(avian)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include ${CMAKE_CURRENT_SOURCE_DIR}/src)


if (NOT LIBRARY_OUTPUT_PATH)
    set(LIBRARY_OUTPUT_PATH ${CMAKE_CURRENT_BINARY_DIR}/bin CACHE PATH "Single output directory for building all libraries.")
    mark_as_advanced(LIBRARY_OUTPUT_PATH)
endif ()


if (NOT CMAKE_RUNTIME_OUTPUT_DIRECTORY)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin CACHE PATH "Single output directory for building all exec.")
    mark_as_advanced(CMAKE_RUNTIME_OUTPUT_DIRECTORY)
endif ()


set(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_BINARY_DIR}/bin)


if (NOT AVIAN_ARCH)
    set(AVIAN_ARCH AVIAN_ARCH_X86_64)
endif ()

include("cmake/Platform.cmake")

if (APPLE)
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/jni/darwin)
    set(TARGET_FORMAT AVIAN_FORMAT_MACHO)
    set(TARGET_FORMAT_OBJ macho)
elseif (WIN32)
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/jni/win32)
    set(TARGET_FORMAT AVIAN_FORMAT_PE)
    set(TARGET_FORMAT_OBJ pe)
elseif (LINUX)
    #TODO
    #include_directories(${CMAKE_CURRENT_SOURCE_DIR}/jni/win32)
    set(TARGET_FORMAT AVIAN_FORMAT_ELF)
    set(TARGET_FORMAT_OBJ elf)
endif ()

add_definitions(
        -DAVIAN_TARGET_ARCH=${AVIAN_ARCH}
        -DAVIAN_TARGET_FORMAT=${TARGET_FORMAT}
        -DTARGET_BYTES_PER_WORD=8
        -D__STDC_LIMIT_MACROS
        -D__STDC_CONSTANT_MACROS
        -DUSE_ATOMIC_OPERATIONS
        -DAVIAN_JAVA_HOME=""
        -DAVIAN_EMBED_PREFIX="/avian-embedded"
        -DAVIAN_VERSION="1.3.0"
        -DBOOT_CLASSPATH="[classpathJar]"
        -DAVIAN_CLASSPATH="[classpathJar]"
        -D_JNI_IMPLEMENTATION_
)

set(AVIAN_PROJECT_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR})
set(AVIAN_PROJECT_OUTPUT_DIR ${CMAKE_CURRENT_BINARY_DIR})

set(CLASSPATH_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/classpath)


include_directories(${CMAKE_CURRENT_BINARY_DIR})


add_subdirectory(classpath)


set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${PLATFORM_CXX_FLAGS}")

include(CTest)

# Sadly, we can't use the 'test' target, as that's coopted by ctest
add_custom_target(check ${CMAKE_CTEST_COMMAND} -V)

add_subdirectory(src)
add_subdirectory(unittest)

cmake_minimum_required(VERSION 2.6)
project(type-generator)

if (WIN32)
    set(BUILD_SYSTEM WINDOWS)
endif ()

if (NOT BUILD_SYSTEM)
    set(BUILD_SYSTEM POSIX)
endif ()

if (BUILD_SYSTEM MATCHES "WINDOWS")
    set(SYSTEM_SRC ../../system/windows.cpp ../../system/windows/crash.cpp ../../system/windows/memory.cpp ../../system/windows/signal.cpp)
else()
    set(SYSTEM_SRC ../../system/posix.cpp ../../system/posix/crash.cpp ../../system/posix/memory.cpp ../../system/posix/signal.cpp)
endif()

include(../../../cmake/Platform.cmake)

include_directories(../..  ../../.. ../../../include)

add_executable(type_generator main.cpp ../../finder.cpp ../../util/arg-parser.cpp ../../util/fixed-allocator.cpp ${SYSTEM_SRC})

target_link_libraries(type_generator z ${PLATFORM_LIBS})

#set(TYPE_GENERATOR ${AVIAN_PROJECT_OUTPUT_DIR}/bin/type_generator)


install(TARGETS type_generator RUNTIME DESTINATION bin)


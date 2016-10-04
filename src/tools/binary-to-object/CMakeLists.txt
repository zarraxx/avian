cmake_minimum_required(VERSION 2.6)
project(type-binary_to_object)

add_definitions(
        -DAVIAN_TARGET_ARCH=AVIAN_ARCH_UNKNOWN
        -DAVIAN_TARGET_FORMAT=AVIAN_FORMAT_UNKNOW
)

include(../../../cmake/Platform.cmake)

include_directories(../..  ../../.. ../../../include)

add_executable(binary_to_object main.cpp ../object-writer/elf.cpp ../object-writer/mach-o.cpp ../object-writer/pe.cpp ../object-writer/tools.cpp)

#target_link_libraries(binary_to_object )

install(TARGETS binary_to_object RUNTIME DESTINATION bin)

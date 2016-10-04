add_subdirectory(codegen)
add_subdirectory(system)
add_subdirectory(heap)
add_subdirectory(util)
add_subdirectory(tools)

if (APPLE)
    set(CMAKE_MACOSX_RPATH 1)
endif ()

enable_language(ASM)



set(VM_CLASSPATH classpath-avian.cpp)
set(VM_COMMON boot.cpp debug-util.cpp builtin.cpp finder.cpp heapdump.cpp heapwalk.cpp jnienv.cpp machine.cpp process.cpp util.cpp )

set(VM_INTERPRET interpret.cpp)

if (AVIAN_ARCH MATCHES "AVIAN_ARCH_X86_64")
    set(AVIAN_ARCH_OBJ x86_64)
elseif(AVIAN_ARCH MATCHES "AVIAN_ARCH_X86")
    set(AVIAN_ARCH_OBJ i386)
elseif(AVIAN_ARCH MATCHES "AVIAN_ARCH_ARM64")
    set(AVIAN_ARCH_OBJ arm64)
elseif(AVIAN_ARCH MATCHES "AVIAN_ARCH_ARM")
    set(AVIAN_ARCH_OBJ arm)
endif ()

set(VM_INTERPRET ${VM_INTERPRET} ${AVIAN_ARCH_OBJ}.S)

set(VM_JNI_IMPLEMENTATION_SRC
        ${CLASSPATH_SOURCE_DIR}/java-io.cpp
        ${CLASSPATH_SOURCE_DIR}/java-lang.cpp
        ${CLASSPATH_SOURCE_DIR}/java-net.cpp
        ${CLASSPATH_SOURCE_DIR}/java-nio.cpp
        ${CLASSPATH_SOURCE_DIR}/java-util.cpp
        ${CLASSPATH_SOURCE_DIR}/java-util-zip.cpp
        ${CLASSPATH_SOURCE_DIR}/sockets.cpp)

#message(STATUS "VM_INTERPRET:" ${VM_INTERPRET})

set(VM_SRC ${VM_COMMON} ${VM_CLASSPATH} ${VM_INTERPRET}  ${VM_JNI_IMPLEMENTATION_SRC})

set(BINARY_TO_OBJECT bin/binary_to_object)


if (NOT WIN32)
    set(CLASSPATH_OBJ_NAME ${AVIAN_PROJECT_OUTPUT_DIR}/bin/classpath.o)
    else()
    set(CLASSPATH_OBJ_NAME ${AVIAN_PROJECT_OUTPUT_DIR}/bin/classpath.obj)
endif ()


add_custom_command(OUTPUT CLASSPATH_OBJ
        WORKING_DIRECTORY ${AVIAN_PROJECT_OUTPUT_DIR}
        COMMAND  ${BINARY_TO_OBJECT} ${AVIAN_PROJECT_OUTPUT_DIR}/bin/rt.jar ${CLASSPATH_OBJ_NAME}   _binary_classpath_jar_start 	_binary_classpath_jar_end ${TARGET_FORMAT_OBJ} ${AVIAN_ARCH_OBJ}
        )
#add_dependencies(CLASSPATH_OBJ External_type-generator External_binary-to-object jvm_classpath_rt)

SET_SOURCE_FILES_PROPERTIES(
        ${CLASSPATH_OBJ_NAME}
        PROPERTIES
        EXTERNAL_OBJECT true
        GENERATED true
)

add_library(avian_jvm SHARED ${VM_SRC} CLASSPATH_OBJ ${CLASSPATH_OBJ_NAME})
target_link_libraries(avian_jvm avian_util avian_heap avian_system ${PLATFORM_LIBS})
set_target_properties(avian_jvm PROPERTIES OUTPUT_NAME "jvm")
SET_TARGET_PROPERTIES(
        avian_jvm
        PROPERTIES
        LINKER_LANGUAGE CXX
)
add_dependencies(avian_jvm   External_type-generator External_binary-to-object jvm_classpath_rt)


#add_custom_command(TARGET avian_jvm
#        PRE_BUILD
#)



add_executable(avian main.cpp)

target_compile_definitions(avian PRIVATE BOOT_LIBRARY="libjvm.dylib")
target_link_libraries(avian avian_jvm  ${PLATFORM_LIBS})



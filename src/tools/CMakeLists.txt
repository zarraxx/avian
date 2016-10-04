#add_subdirectory(binary-to-object)
#add_subdirectory(object-writer)
#add_subdirectory(type-generator)

include(ExternalProject)

set(MAKE make)

ExternalProject_Add(
        External_type-generator
        #URL "${ZLIB_PACKAGE}"
        SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/type-generator
        #PATCH_COMMAND sed -e "s/PREFIX =/PREFIX = ${CROSS_COMPILER}-/g" -i \"\" ${varSrcDir}/win32/Makefile.gcc
        #CONFIGURE_COMMAND echo "NO CONFIGURE"
        BUILD_COMMAND ${MAKE}
        BUILD_IN_SOURCE 0
        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${AVIAN_PROJECT_OUTPUT_DIR}
        #INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}

        #INSTALL_COMMAND ${MAKE} install

)

ExternalProject_Add(
        External_binary-to-object
        #URL "${ZLIB_PACKAGE}"
        SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/binary-to-object
        #PATCH_COMMAND sed -e "s/PREFIX =/PREFIX = ${CROSS_COMPILER}-/g" -i \"\" ${varSrcDir}/win32/Makefile.gcc
        #CONFIGURE_COMMAND echo "NO CONFIGURE"
        BUILD_COMMAND ${MAKE}
        BUILD_IN_SOURCE 0
        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${AVIAN_PROJECT_OUTPUT_DIR}
        #INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}
        #INSTALL_COMMAND ${MAKE} install
)


add_dependencies( External_type-generator jvm_classpath_rt)
add_dependencies( External_binary-to-object jvm_classpath_rt)

set(TYPE_GENERATOR ${AVIAN_PROJECT_OUTPUT_DIR}/bin/type_generator)


add_custom_command(TARGET External_type-generator
        POST_BUILD
        COMMAND  ${TYPE_GENERATOR} -cp ${AVIAN_PROJECT_OUTPUT_DIR}/bin/classpath -i ${AVIAN_PROJECT_SOURCE_DIR}/src/types.def -o ${AVIAN_PROJECT_OUTPUT_DIR}/type-enums.cpp -t enums
        )


add_custom_command(TARGET External_type-generator
        POST_BUILD
        COMMAND  ${TYPE_GENERATOR} -cp ${AVIAN_PROJECT_OUTPUT_DIR}/bin/classpath -i ${AVIAN_PROJECT_SOURCE_DIR}/src/types.def -o ${AVIAN_PROJECT_OUTPUT_DIR}/type-declarations.cpp -t declarations
        )

add_custom_command(TARGET External_type-generator
        POST_BUILD
        COMMAND  ${TYPE_GENERATOR} -cp ${AVIAN_PROJECT_OUTPUT_DIR}/bin/classpath -i ${AVIAN_PROJECT_SOURCE_DIR}/src/types.def -o ${AVIAN_PROJECT_OUTPUT_DIR}/type-constructors.cpp -t constructors
        )

add_custom_command(TARGET External_type-generator
        POST_BUILD
        COMMAND  ${TYPE_GENERATOR} -cp ${AVIAN_PROJECT_OUTPUT_DIR}/bin/classpath -i ${AVIAN_PROJECT_SOURCE_DIR}/src/types.def -o ${AVIAN_PROJECT_OUTPUT_DIR}/type-initializations.cpp -t initializations
        )

add_custom_command(TARGET External_type-generator
        POST_BUILD
        COMMAND  ${TYPE_GENERATOR} -cp ${AVIAN_PROJECT_OUTPUT_DIR}/bin/classpath -i ${AVIAN_PROJECT_SOURCE_DIR}/src/types.def -o ${AVIAN_PROJECT_OUTPUT_DIR}/type-java-initializations.cpp -t java-initializations
        )


add_custom_command(TARGET External_type-generator
        POST_BUILD
        COMMAND  ${TYPE_GENERATOR} -cp ${AVIAN_PROJECT_OUTPUT_DIR}/bin/classpath -i ${AVIAN_PROJECT_SOURCE_DIR}/src/types.def -o ${AVIAN_PROJECT_OUTPUT_DIR}/type-name-initializations.cpp -t name-initializations
        )


add_custom_command(TARGET External_type-generator
        POST_BUILD
        COMMAND  ${TYPE_GENERATOR} -cp ${AVIAN_PROJECT_OUTPUT_DIR}/bin/classpath -i ${AVIAN_PROJECT_SOURCE_DIR}/src/types.def -o ${AVIAN_PROJECT_OUTPUT_DIR}/type-maps.cpp -t  maps
        )

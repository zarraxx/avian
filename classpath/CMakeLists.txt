find_package(Java REQUIRED)
include(UseJava)



set(CLASSPATH_SOURCES_AVIAN
        ${CLASSPATH_SOURCE_DIR}/avian/Addendum.java
        ${CLASSPATH_SOURCE_DIR}/avian/AnnotationInvocationHandler.java
        ${CLASSPATH_SOURCE_DIR}/avian/Assembler.java
        ${CLASSPATH_SOURCE_DIR}/avian/Callback.java
        ${CLASSPATH_SOURCE_DIR}/avian/Cell.java
        ${CLASSPATH_SOURCE_DIR}/avian/ClassAddendum.java
        ${CLASSPATH_SOURCE_DIR}/avian/Classes.java
        ${CLASSPATH_SOURCE_DIR}/avian/Code.java
        ${CLASSPATH_SOURCE_DIR}/avian/ConstantPool.java
        ${CLASSPATH_SOURCE_DIR}/avian/Continuations.java
        ${CLASSPATH_SOURCE_DIR}/avian/FieldAddendum.java
        ${CLASSPATH_SOURCE_DIR}/avian/Function.java
        ${CLASSPATH_SOURCE_DIR}/avian/IncompatibleContinuationException.java
        ${CLASSPATH_SOURCE_DIR}/avian/InnerClassReference.java
        ${CLASSPATH_SOURCE_DIR}/avian/Machine.java
        ${CLASSPATH_SOURCE_DIR}/avian/MethodAddendum.java
        ${CLASSPATH_SOURCE_DIR}/avian/Pair.java
        ${CLASSPATH_SOURCE_DIR}/avian/Singleton.java
        ${CLASSPATH_SOURCE_DIR}/avian/Stream.java
        ${CLASSPATH_SOURCE_DIR}/avian/SystemClassLoader.java
        ${CLASSPATH_SOURCE_DIR}/avian/Traces.java
        ${CLASSPATH_SOURCE_DIR}/avian/VMClass.java
        ${CLASSPATH_SOURCE_DIR}/avian/VMField.java
        ${CLASSPATH_SOURCE_DIR}/avian/VMMethod.java
        ${CLASSPATH_SOURCE_DIR}/avian/avianvmresource/Handler.java
        ${CLASSPATH_SOURCE_DIR}/avian/file/Handler.java
        )
set(CLASSPATH_SOURCES_JAVA_INVOKE
        ${CLASSPATH_SOURCE_DIR}/java/lang/invoke/MethodHandle.java
        ${CLASSPATH_SOURCE_DIR}/java/lang/invoke/MethodHandles.java
        ${CLASSPATH_SOURCE_DIR}/java/lang/invoke/MethodType.java
        ${CLASSPATH_SOURCE_DIR}/java/lang/invoke/LambdaMetafactory.java
        ${CLASSPATH_SOURCE_DIR}/java/lang/invoke/LambdaConversionException.java
        ${CLASSPATH_SOURCE_DIR}/java/lang/invoke/CallSite.java

        )

#if (Enable_OPENJDK)
set(CLASSPATH_SOURCES ${CLASSPATH_SOURCES_AVIAN} ${CLASSPATH_SOURCES_JAVA_INVOKE}
        ${CLASSPATH_SOURCE_DIR}/dalvik/system/BaseDexClassLoader.java
        ${CLASSPATH_SOURCE_DIR}/libcore/reflect/AnnotationAccess.java
        ${CLASSPATH_SOURCE_DIR}/sun/reflect/ConstantPool.java
        ${CLASSPATH_SOURCE_DIR}/java/net/ProtocolFamily.java
        ${CLASSPATH_SOURCE_DIR}/java/net/StandardProtocolFamily.java
        ${CLASSPATH_SOURCE_DIR}/sun/misc/Cleaner.java
        ${CLASSPATH_SOURCE_DIR}/sun/misc/Unsafe.java
        ${CLASSPATH_SOURCE_DIR}/java/lang/Object.java
        ${CLASSPATH_SOURCE_DIR}/java/lang/Class.java
        ${CLASSPATH_SOURCE_DIR}/java/lang/ClassLoader.java
        ${CLASSPATH_SOURCE_DIR}/java/lang/Package.java
        ${CLASSPATH_SOURCE_DIR}/java/lang/reflect/Proxy.java
        ${CLASSPATH_SOURCE_DIR}/java/lang/reflect/Field.java
        ${CLASSPATH_SOURCE_DIR}/java/lang/reflect/SignatureParser.java
        ${CLASSPATH_SOURCE_DIR}/java/lang/reflect/Constructor.java
        ${CLASSPATH_SOURCE_DIR}/java/lang/reflect/AccessibleObject.java
        ${CLASSPATH_SOURCE_DIR}/java/lang/reflect/Method.java
        )
#endif ()

FILE(GLOB CLASSPATH_SOURCES1 ${CLASSPATH_SOURCE_DIR}/*/*.java)
FILE(GLOB CLASSPATH_SOURCES2 ${CLASSPATH_SOURCE_DIR}/*/*/*.java)
FILE(GLOB CLASSPATH_SOURCES3 ${CLASSPATH_SOURCE_DIR}/*/*/*/*.java)
FILE(GLOB CLASSPATH_SOURCES4 ${CLASSPATH_SOURCE_DIR}/*/*/*/*/*.java)
FILE(GLOB CLASSPATH_SOURCES5 ${CLASSPATH_SOURCE_DIR}/*/*/*/*/*/*.java)
FILE(GLOB CLASSPATH_SOURCES6 ${CLASSPATH_SOURCE_DIR}/*/*/*/*/*/*/*.java)
FILE(GLOB CLASSPATH_SOURCES7 ${CLASSPATH_SOURCE_DIR}/*/*/*/*/*/*/*/*.java)
FILE(GLOB CLASSPATH_SOURCES8 ${CLASSPATH_SOURCE_DIR}/*/*/*/*/*/*/**/*/*.java)


set(JAVA_SOURCE ${CLASSPATH_SOURCES1} ${CLASSPATH_SOURCES2} ${CLASSPATH_SOURCES3} ${CLASSPATH_SOURCES4}
        ${CLASSPATH_SOURCES5} ${CLASSPATH_SOURCES6} ${CLASSPATH_SOURCES7} ${CLASSPATH_SOURCES8})


add_jar(jvm_classpath_rt ${JAVA_SOURCE}  OUTPUT_DIR ${PROJECT_BINARY_DIR}/bin OUTPUT_NAME rt)


add_custom_command(TARGET jvm_classpath_rt
        POST_BUILD
        COMMAND  unzip -o ${PROJECT_BINARY_DIR}/bin/rt.jar -d ${PROJECT_BINARY_DIR}/bin/classpath
        )

#foreach(JAVA_SOURCE ${CLASSPATH_SOURCES})
#    string(REPLACE ${CLASSPATH_SOURCE_DIR} "" DEST ${JAVA_SOURCE})
#    message(STATUS ${JAVA_SOURCE})
#
#    #string(REPLACE "/" "" DEST ${JAVA_SOURCE})
#    string(REPLACE "/" ";" DEST ${DEST})
#    set(TEMP "")
#    #message(STATUS ${DEST})
#    foreach(D ${DEST})
#        if (NOT D MATCHES ".java")
#            set(TEMP ${TEMP}/${D})
#        endif ()
#    endforeach()
#    set(DEST ${TEMP})
#    #message(STATUS ${DEST})
#
#    #file(COPY  ${JAVA_SOURCE} DESTINATION ${AVIAN_PROJECT_OUTPUT_DIR}/classpath${DEST})
#endforeach()


#file(COPY  ${CLASSPATH_SOURCES_AVIAN} DESTINATION ${AVIAN_PROJECT_OUTPUT_DIR}/classpath/avian)
#file(COPY  ${CLASSPATH_SOURCES_JAVA_INVOKE} DESTINATION ${AVIAN_PROJECT_OUTPUT_DIR}/classpath/java/lang/invoke)
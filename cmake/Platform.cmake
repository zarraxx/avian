find_package(ZLIB REQUIRED)
include_directories(${ZLIB_INCLUDE_DIRS})

IF (APPLE)
   INCLUDE_DIRECTORIES ( /Developer/Headers/FlatCarbon )
   FIND_LIBRARY(CORE_FOUNDATION_LIBRARY CoreFoundation)

   MARK_AS_ADVANCED (CORE_FOUNDATION_LIBRARY)

   SET(PLATFORM_LIBS ${CORE_FOUNDATION_LIBRARY})
ENDIF()

IF (MSVC)
	SET(PLATFORM_CXX_FLAGS "/Wall")
ELSE()
	SET(PLATFORM_CXX_FLAGS "-Wall -Wextra  -Wunused-parameter -Winit-self -Wno-non-virtual-dtor -std=c++0x -fno-rtti ")
  SET(PLATFORM_LIBS ${PLATFORM_LIBS}  ${ZLIB_LIBRARIES})
ENDIF()

if (NOT WIN32)
    set(PLATFORM_LIBS ${PLATFORM_LIBS}  pthread dl)
else()
    set(PLATFORM_LIBS ${PLATFORM_LIBS}  ws2_32 iphlpapi)
endif ()




set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${PLATFORM_CXX_FLAGS}")
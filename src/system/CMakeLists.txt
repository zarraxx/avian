
if (WIN32)
  #todo: support mingw compiler
  add_library(avian_system windows.cpp windows/crash.cpp windows/memory.cpp windows/signal.cpp)
else()
  add_library(avian_system posix.cpp posix/crash.cpp posix/memory.cpp posix/signal.cpp)
endif()

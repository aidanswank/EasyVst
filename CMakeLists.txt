# first build vst3sdk and paste root path here
set(vst3sdk_path "/Users/aidan/dev/vst/vst3_x86_64/vst3sdk")
message("USING VST3SDK PATH PROVIDED: ${vst3sdk_path}")

set(CMAKE_OSX_ARCHITECTURES "x86_64" CACHE INTERNAL "" FORCE)

set(ENV{VCPKG_DISABLE_METRICS} TRUE) #disable telemetry

cmake_minimum_required(VERSION 3.15)

set(TARGET_EXE EasyVst)
project(${TARGET_EXE})

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

find_package(SDL2 CONFIG REQUIRED)
find_package(portaudio CONFIG REQUIRED)
find_package(rtmidi CONFIG REQUIRED)
find_package(unofficial-concurrentqueue CONFIG REQUIRED)

include_directories(${CMAKE_SOURCE_DIR} include ${vst3sdk_path})
link_directories(${vst3sdk_path}/build/lib/Debug)

file(GLOB SOURCES 
    examples/SimpleMidiExample.cpp 
    src/window.mm
	${vst3sdk_path}/public.sdk/source/vst/hosting/connectionproxy.cpp
	${vst3sdk_path}/public.sdk/source/vst/hosting/eventlist.cpp
	${vst3sdk_path}/public.sdk/source/vst/hosting/hostclasses.cpp
	${vst3sdk_path}/public.sdk/source/vst/hosting/module.cpp
	${vst3sdk_path}/public.sdk/source/vst/hosting/parameterchanges.cpp
	${vst3sdk_path}/public.sdk/source/vst/hosting/pluginterfacesupport.cpp
	${vst3sdk_path}/public.sdk/source/vst/hosting/plugprovider.cpp
	${vst3sdk_path}/public.sdk/source/vst/hosting/processdata.cpp
	${vst3sdk_path}/public.sdk/source/vst/utility/stringconvert.cpp
	${vst3sdk_path}/public.sdk/source/vst/vstinitiids.cpp
	${vst3sdk_path}/public.sdk/source/vst/hosting/module_mac.mm
)
file(GLOB INCLUDES include/EasyVst.h ${vst3sdk_path})

add_executable(${TARGET_EXE}
    ${SOURCES}
    ${INCLUDES}
    ${CMAKE_SOURCE_DIR}/src/EasyVst.cpp)
target_link_libraries(${TARGET_EXE} SDL2::SDL2 portaudio_static RtMidi::rtmidi unofficial::concurrentqueue::concurrentqueue base pluginterfaces sdk_common sdk)

# for xcode generator 
if(CMAKE_GENERATOR STREQUAL Xcode)
    set(CMAKE_C_FLAGS "-x objective-c")
    set(CMAKE_CXX_FLAGS "-x objective-c++")
    set(CMAKE_EXE_LINKER_FLAGS "-framework Cocoa -framework AppKit -framework CoreData -framework Foundation")
    set_property (TARGET ${TARGET_EXE} APPEND_STRING PROPERTY COMPILE_FLAGS "-fobjc-arc")
else() #for unix makefiles 
    set_property (TARGET ${TARGET_EXE} APPEND_STRING PROPERTY COMPILE_FLAGS "-fobjc-arc -ObjC++")
endif()
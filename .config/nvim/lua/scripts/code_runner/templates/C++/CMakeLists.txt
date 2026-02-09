cmake_minimum_required(VERSION 3.10)
project(MyCppProject LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

file(GLOB_RECURSE SRC_FILES "src/*.cpp" "main.cpp")

add_executable(main ${SRC_FILES})

target_include_directories(main PRIVATE include)

target_compile_options(main PRIVATE -Wall -Wextra)

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_compile_options(main PRIVATE -g -O0)
elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
    target_compile_options(main PRIVATE -O2)
    target_compile_definitions(main PRIVATE NDEBUG)
endif()

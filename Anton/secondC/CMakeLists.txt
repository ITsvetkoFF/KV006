cmake_minimum_required(VERSION 2.8)
project(secondC)

set (CMAKE_CXX_FLAGS "-std=c++0x -stdlib=libc++ -g3 -Wall -O0")

set(HEADER Hello.h MD5.h)
set(SOURCE_FILES main.cpp Hello.cpp MD5.cpp)

add_executable(secondC ${SOURCE_FILES})
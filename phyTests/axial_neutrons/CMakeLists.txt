cmake_minimum_required(VERSION 3.15)

# Project name
project(neutrons)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find ROOT package
find_package(ROOT REQUIRED)

# Include ROOT headers
include_directories(${ROOT_INCLUDE_DIRS})

# Include HIPO headers
include_directories($ENV{HIPO}/include/hipo4)

# Add executable
add_executable(neutrons neutrons.cc)

# Link libraries
target_link_libraries(neutrons ${ROOT_LIBRARIES} -L/opt/homebrew/lib/ -L$ENV{HIPO}/lib -lhipo4 -llz4)
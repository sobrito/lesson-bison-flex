cmake_minimum_required(VERSION 3.7)
project(lesson)


set(CMAKE_CXX_STANDARD 11)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)


bison_target(lesson-parser
        calc-parser.y
        ${CMAKE_CURRENT_BINARY_DIR}/parser.tab.cpp
        )

flex_target(lesson-scanner
        calc-scanner.l
        ${CMAKE_CURRENT_BINARY_DIR}/scanner.tab.cpp
        )
add_flex_bison_dependency(lesson-scanner lesson-parser)
add_executable(lesson main.cpp ${BISON_MyParser_OUTPUTS} ${FLEX_MyScanner_OUTPUTS} main.cpp)

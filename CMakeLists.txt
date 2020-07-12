cmake_minimum_required(VERSION 3.7)
project(lesson)


set(CMAKE_CXX_STANDARD 11)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)


bison_target(lesson-sentence
        calc-sentence.y
        ${CMAKE_CURRENT_BINARY_DIR}/sentence.tab.cpp
        )
message("Bison header ${BISON_lesson-sentence_OUTPUT_HEADER}")
add_definitions(-DYACC_TABLE_H="${BISON_lesson-sentence_OUTPUT_HEADER}")

flex_target(lesson-syntax
        calc-syntax.l
        ${CMAKE_CURRENT_BINARY_DIR}/syntax.tab.cpp
        )
add_flex_bison_dependency(lesson-syntax lesson-sentence)
add_executable(lesson main.cpp
        ${BISON_lesson-syntax_OUTPUTS}
        ${FLEX_lesson-syntax_OUTPUTS}
        Parser.cpp
        Parser.h
        main.cpp
        )

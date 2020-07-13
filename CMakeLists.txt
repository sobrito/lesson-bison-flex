cmake_minimum_required(VERSION 3.7)
project(lesson)


set(CMAKE_CXX_STANDARD 11)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-write-strings")

find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)
include_directories(${CMAKE_CURRENT_BINARY_DIR})
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

set(LESSON_LIBS ${LESSON_LIBS} l )

foreach (REQUIRED_LIBRARY ${LESSON_LIBS})
    find_library(REQUIRED_LIBRARY_PATH NAMES ${REQUIRED_LIBRARY})
    if (NOT REQUIRED_LIBRARY_PATH)
        message(FATAL_ERROR "lib ${REQUIRED_LIBRARY} not found")
    endif ()
    message("library ${REQUIRED_LIBRARY} is found")
endforeach (REQUIRED_LIBRARY)

message("out ${BISON_lesson-sentence_OUTPUTS} ${FLEX_lesson-syntax_OUTPUTS}")

add_executable(lesson
        main.cpp
        ${BISON_lesson-sentence_OUTPUTS}
        ${FLEX_lesson-syntax_OUTPUTS}
        Parser.cpp
        Parser.h
        )
target_link_libraries(lesson ${LESSON_LIBS})
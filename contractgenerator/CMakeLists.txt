cmake_minimum_required(VERSION 3.16)

project(contractgenerator VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED printsupport)

qt_add_executable(appcontractgenerator
    main.cpp filereader.h filereader.cpp
)

qt_add_qml_module(appcontractgenerator
    URI contractgenerator
    VERSION 1.0
    QML_FILES main.qml LabelInput.qml
)

set_target_properties(appcontractgenerator PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appcontractgenerator
    PRIVATE Qt6::Quick PRIVATE Qt6::PrintSupport )

install(TARGETS appcontractgenerator
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

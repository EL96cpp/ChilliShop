cmake_minimum_required(VERSION 3.16)

project(Employee VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appEmployee
    main.cpp
    client.cpp
    client.h
    Images.qrc
    Fonts.qrc
)

qt_add_qml_module(appEmployee
    URI Employee
    VERSION 1.0
    QML_FILES Main.qml LoginPage.qml WorkspacePage.qml ErrorMessage.qml IssuingOrdersListForm.qml PrepearingOrdersListForm.qml
    IssuingOrdersListModel.qml PrepearingOrdersListModel.qml EmployeeDataForm.qml IssuingOrderForm.qml PrepearingOrderForm.qml
    IssuingOrderModel.qml PrepearingOrderModel.qml IssuingOrdersListCopyModel.qml

)

set_target_properties(appEmployee PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appEmployee
    PRIVATE Qt6::Quick
)

install(TARGETS appEmployee
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

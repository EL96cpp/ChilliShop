cmake_minimum_required(VERSION 3.16)

project(ChilliWorld VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick Network)

qt_standard_project_setup()

qt_add_executable(appChilliWorld
    main.cpp
    Fonts.qrc
    Images.qrc
    client.cpp
    client.h
)

qt_add_qml_module(appChilliWorld
    URI ChilliWorld
    VERSION 1.0
    QML_FILES Main.qml MainPage.qml ProfilePage.qml LoginForm.qml RegisterForm.qml
              GoodDelegate.qml SaucesModel.qml SeasoningsModel.qml SeedsModel.qml
              CopyModel.qml CartModel.qml Filters.qml CartView.qml GoodsGrid.qml
              CustomSpinbox.qml ErrorMessage.qml OrdersForm.qml ChangeNameForm.qml
)

set_target_properties(appChilliWorld PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appChilliWorld
    PRIVATE Qt6::Quick
)

install(TARGETS appChilliWorld
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

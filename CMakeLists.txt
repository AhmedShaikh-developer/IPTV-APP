cmake_minimum_required(VERSION 3.16)

project(untitled VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Widgets Quick Network)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets Quick Qml QuickControls2 Network)

# Find libVLC
# First try to find SDK (preferred method)
find_path(VLC_INCLUDE_DIR
    NAMES vlc/vlc.h
    PATHS
        "$ENV{ProgramFiles}/VideoLAN/VLC/sdk/include"
        "$ENV{ProgramFiles\(x86\)}/VideoLAN/VLC/sdk/include"
        "C:/Program Files/VideoLAN/VLC/sdk/include"
        "C:/Program Files (x86)/VideoLAN/VLC/sdk/include"
        "$ENV{VLC_ROOT}/sdk/include"
        "$ENV{VLC_ROOT}/include"
    NO_DEFAULT_PATH
)

find_library(VLC_LIBRARY
    NAMES vlc libvlc
    PATHS
        "$ENV{ProgramFiles}/VideoLAN/VLC/sdk/lib"
        "$ENV{ProgramFiles\(x86\)}/VideoLAN/VLC/sdk/lib"
        "C:/Program Files/VideoLAN/VLC/sdk/lib"
        "C:/Program Files (x86)/VideoLAN/VLC/sdk/lib"
        "$ENV{VLC_ROOT}/sdk/lib"
        "$ENV{VLC_ROOT}/lib"
    NO_DEFAULT_PATH
)

# If SDK not found, try to find VLC installation directory
if(NOT VLC_INCLUDE_DIR OR NOT VLC_LIBRARY)
    message(WARNING "VLC SDK not found. Looking for VLC installation directory...")
    
    # Find VLC installation directory
    find_path(VLC_ROOT_DIR
        NAMES libvlc.dll libvlccore.dll
        PATHS
            "$ENV{ProgramFiles}/VideoLAN/VLC"
            "$ENV{ProgramFiles\(x86\)}/VideoLAN/VLC"
            "C:/Program Files/VideoLAN/VLC"
            "C:/Program Files (x86)/VideoLAN/VLC"
            "$ENV{VLC_ROOT}"
        NO_DEFAULT_PATH
    )
    
    if(VLC_ROOT_DIR)
        message(STATUS "Found VLC installation: ${VLC_ROOT_DIR}")
        message(WARNING "SDK not found. You need to:")
        message(WARNING "  1. Download VLC SDK separately from https://download.videolan.org/pub/videolan/vlc/")
        message(WARNING "  2. Extract SDK to: ${VLC_ROOT_DIR}/sdk/")
        message(WARNING "  3. Or set VLC_ROOT environment variable to SDK location")
        
        # Try to find headers in alternative locations
        find_path(VLC_INCLUDE_DIR
            NAMES vlc/vlc.h
            PATHS
                "${VLC_ROOT_DIR}/include"
                "${VLC_ROOT_DIR}/sdk/include"
                "$ENV{VLC_SDK}/include"
            NO_DEFAULT_PATH
        )
        
        # Try to find library in alternative locations
        find_library(VLC_LIBRARY
            NAMES vlc libvlc
            PATHS
                "${VLC_ROOT_DIR}/lib"
                "${VLC_ROOT_DIR}/sdk/lib"
                "$ENV{VLC_SDK}/lib"
            NO_DEFAULT_PATH
        )
    endif()
endif()

# Last resort: search system paths
if(NOT VLC_INCLUDE_DIR OR NOT VLC_LIBRARY)
    message(WARNING "Searching system paths for VLC...")
    find_path(VLC_INCLUDE_DIR NAMES vlc/vlc.h)
    find_library(VLC_LIBRARY NAMES vlc libvlc)
endif()

if(VLC_LIBRARY AND VLC_INCLUDE_DIR)
    message(STATUS "Found libVLC: ${VLC_LIBRARY}")
    message(STATUS "Found VLC includes: ${VLC_INCLUDE_DIR}")
    add_definitions(-DHAVE_VLC)
    set(VLC_FOUND TRUE)
else()
    message(WARNING "libVLC not found! VLC features will be disabled.")
    message(WARNING "To enable VLC support, install VLC media player from https://www.videolan.org/vlc/")
    set(VLC_FOUND FALSE)
endif()

set(PROJECT_SOURCES
        main.cpp
        AppState.cpp
        qml.qrc
        src/PlaylistManager.cpp
        src/PlaylistManager.h
        src/M3UParser.cpp
        src/M3UParser.h
        src/ChannelModel.cpp
        src/ChannelModel.h
        src/VodModel.cpp
        src/VodModel.h
        src/LiveChannel.cpp
        src/LiveChannel.h
        src/VodItem.cpp
        src/VodItem.h
        src/FilePicker.cpp
        src/FilePicker.h
        src/VlcPlayer.cpp
        src/VlcPlayer.h
        src/ExternalVlcLauncher.cpp
        src/ExternalVlcLauncher.h
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(untitled
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
    )
# Define target properties for Android with Qt 6 as:
#    set_property(TARGET untitled APPEND PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
#                 ${CMAKE_CURRENT_SOURCE_DIR}/android)
# For more information, see https://doc.qt.io/qt-6/qt-add-executable.html#target-creation
else()
    if(ANDROID)
        add_library(untitled SHARED
            ${PROJECT_SOURCES}
        )
# Define properties for Android with Qt 5 after find_package() calls as:
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
    else()
        add_executable(untitled
            ${PROJECT_SOURCES}
        )
    endif()
endif()

target_link_libraries(untitled PRIVATE Qt${QT_VERSION_MAJOR}::Quick Qt${QT_VERSION_MAJOR}::Qml Qt${QT_VERSION_MAJOR}::QuickControls2 Qt${QT_VERSION_MAJOR}::Network Qt${QT_VERSION_MAJOR}::Widgets)

# Link libVLC
if(VLC_FOUND AND VLC_LIBRARY AND VLC_INCLUDE_DIR)
    target_include_directories(untitled PRIVATE ${VLC_INCLUDE_DIR})
    target_link_libraries(untitled PRIVATE ${VLC_LIBRARY})
    message(STATUS "libVLC linked successfully")
else()
    message(WARNING "libVLC will not be linked - VLC features disabled")
endif()

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
if(${QT_VERSION} VERSION_LESS 6.1.0)
  set(BUNDLE_ID_OPTION MACOSX_BUNDLE_GUI_IDENTIFIER com.example.untitled)
endif()
set_target_properties(untitled PROPERTIES
    ${BUNDLE_ID_OPTION}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)
include(GNUInstallDirs)
install(TARGETS untitled
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
if(QT_VERSION_MAJOR EQUAL 6)
    qt_finalize_executable(untitled)
endif()



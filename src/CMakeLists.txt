cmake_minimum_required(VERSION 3.13)

find_package(Threads REQUIRED)

# *WIN32* makes it a GUI executable instead of a console application (only relevant on Windows)
add_executable(WickedStarter WIN32)

# Create target for copying assets to correct directory
add_custom_target(WickedStarterAssets)
add_custom_command(TARGET WickedStarterAssets POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
        ${CMAKE_SOURCE_DIR}/assets
        ${CMAKE_CURRENT_BINARY_DIR}
        )

if (WIN32)
    # Add Windows platform specific sources (e.g windowing)
    target_sources(WickedStarter PRIVATE win32/main.cpp win32/main.h win32/resource.h stdafx.h stdafx.cpp win32/targetver.h win32/TemplateWindows.rc)
else ()
    # Add SDL2 platform specific sources (e.g windowing)
    target_sources(WickedStarter PRIVATE sdl2/main.cpp)
endif ()

# Add dependencies (e.g Shaders, Fonts)
add_dependencies(WickedStarter WickedStarterAssets WickedEngineShaders WickedEngineFonts)

# Link libraries with executable
target_link_libraries(WickedStarter PRIVATE WickedEngine WickedEngineUtility Threads::Threads)
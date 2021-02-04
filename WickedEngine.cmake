include(FetchContent)

if (WIN32)
    # Avoid problems with LPCSTR / LPCWSTR conversions
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /D_UNICODE /DUNICODE")
endif ()

# Fetch WickedEngine
FetchContent_Declare(
        wickedengine
        GIT_REPOSITORY "https://github.com/turanszkij/WickedEngine.git"
)
FetchContent_GetProperties(wickedengine)
if (NOT wickedengine_POPULATED)
    FetchContent_Populate(wickedengine)
    add_subdirectory(${wickedengine_SOURCE_DIR} ${wickedengine_BINARY_DIR})
    add_library(WickedEngineUtility ALIAS Utility)
endif ()

# Include WickedEngine
include_directories(${wickedengine_SOURCE_DIR}/WickedEngine)

if (WIN32)
    # This is weird, the library is created as WickedEngine but changes name somewhere
    # If we change the name in CMake manually, linking still works, very *hacky*
    set_target_properties(WickedEngine PROPERTIES OUTPUT_NAME "WickedEngine_Windows")

    # We need to add these additional source files under windows, otherwise we get *unresolved external ...*
    target_sources(WickedEngine PRIVATE
            ${wickedengine_SOURCE_DIR}/WickedEngine/wiNetwork_Windows.cpp
            ${wickedengine_SOURCE_DIR}/WickedEngine/wiGraphicsDevice_DX11.cpp
            ${wickedengine_SOURCE_DIR}/WickedEngine/wiGraphicsDevice_DX12.cpp)

    # We need to add these additional source files under windows, otherwise we get *unresolved external ...*
    target_sources(Utility PRIVATE
            ${wickedengine_SOURCE_DIR}/WickedEngine/Utility/D3D12memAlloc.cpp
            ${wickedengine_SOURCE_DIR}/WickedEngine/Utility/stb_vorbis.c)
endif ()

# Create target for copying shaders to correct directory
add_custom_target(WickedEngineShaders DEPENDS WickedEngine)
add_custom_command(TARGET WickedEngineShaders POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
        ${wickedengine_SOURCE_DIR}/WickedEngine/shaders
        ${CMAKE_BINARY_DIR}/WickedEngine/shaders
        )

# Create target for copying fonts to correct directory
add_custom_target(WickedEngineFonts ALL DEPENDS WickedEngine)
add_custom_command(TARGET WickedEngineFonts POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
        ${wickedengine_SOURCE_DIR}/WickedEngine/fonts
        ${CMAKE_BINARY_DIR}/WickedEngine/fonts
        )
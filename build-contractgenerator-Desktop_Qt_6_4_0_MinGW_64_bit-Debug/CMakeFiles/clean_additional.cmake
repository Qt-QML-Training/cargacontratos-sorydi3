# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appcontractgenerator_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appcontractgenerator_autogen.dir\\ParseCache.txt"
  "appcontractgenerator_autogen"
  )
endif()

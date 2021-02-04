# Wicked Engine CMake Starter Template

## 🎮 What is this

This repository is a starter template for using the Wicked Engine with the CMake build system. 

It enables compilation on both Windows and Linux distributions through a **single build system and project**.

## 📦 Why

The Wicked Engine is great, however, it **suffers from relying on multiple build systems**. 

Using this template it is possible to use CMake for all platforms (currently Windows and Linux) which reduces complexity.

## 📋 Details

This template **does not represent the best CMake practices** out there (I'm not a CMake wizzard 🧙).

It only attempts to **simplify using CMake** together with the Wicked Engine.

While pursuing this goal, it makes **no intrusive changes** to the main Wicked Engine project.

## 🔍 Troubleshooting

### dxc failure

```
Generating ../../../WickedEngine/shaders/spirv/hairparticleVS.cso
dxc failed : Unknown argument: '-all-resources-bound'
```

Try using the provided dxc compiler instead of your local (dxc.exe and dxcompiler.dll).
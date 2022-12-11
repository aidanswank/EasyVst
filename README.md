# EasyVst

EasyVst is a small, easy-to-use VST3 wrapper that makes it easy to host VST3 plugins without using JUCE or any other framework. By default, it uses SDL2 to create the window in which plugin GUIs are displayed; however, it should be straightforward to modify this code to use any other library for window creation.

# Building
<b>Only tested on osx so far!!</b><br>
First build the <a href="https://github.com/steinbergmedia/vst3sdk">vst3sdk</a><br>
Edit the "vst3sdk_path" variable in CMakeLists.txt pointing the "vst3sdk" folder<br>
git clone https://github.com/Microsoft/vcpkg.git<br>
cmake -B build/ . -DCMAKE_TOOLCHAIN_FILE=vcpkg/scripts/buildsystems/vcpkg.cmake<br>
cmake --build build

## License

EasyVst uses the Creative Commons Zero v1.0 Universal license. This license does not apply to the Steinberg VST SDK which is wrapped by EasyVst; the Steinberg SDK has additional terms and conditions to which you must also agree if you choose to incorporate it into your product. See the [LICENSE](LICENSE) file for more information.

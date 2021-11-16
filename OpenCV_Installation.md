> **_NOTE:_** THIS INSTRUCTION TARGETS AT OPENCV < 4.5.0

> FOR VER. >= 4.5.0, REFER TO HERE: https://docs.opencv.org/4.5.0/d7/d9f/tutorial_linux_install.html

REF #1: https://docs.opencv.org/4.4.0/d2/de6/tutorial_py_setup_in_ubuntu.html

REF #2: https://docs.opencv.org/4.4.0/d7/d9f/tutorial_linux_install.html

# Steps for installing opencv

> **_NOTE:_** Setup all pip2/3 & venv (depending on your choice of python environment for build & install opencv) beforehand

## OPTION 1: Install using pre-built binary
```sh
sudo apt-get install libopencv-dev python(3)-opencv
```

## OPTION 2: Build from source (python3 components included)
1. Install OS libs & dependencies
```sh
sudo apt update
sudo apt-get dist-upgrade -> may not be necessary

sudo apt install cmake git gcc g++ build-essential unzip pkg-config

sudo apt install python(3)-dev python(3)-numpy
# NOTE: python(3)-numpy is unnecessary when module numpy was already installed using pip(3) or activated python(3) environment has it already

sudo apt install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt install libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev

# to support gtk2:
sudo apt install libgtk2.0-dev

# to support gtk3:
sudo apt install libgtk-3-dev

# Optional:
sudo apt install libtbb2 libtbb-dev \
                     libdc1394-22 libdc1394-22-dev \
                     libjpeg-dev libpng-dev libtiff-dev libopenexr-dev libwebp-dev

# Not exist in official tutorial but in various other pages:
sudo apt install libxvidcore-dev libx264-dev \
                     libatlas-base-dev gfortran

# For Ubuntu 16.04, add libjasper-dev to add a system level support for the JPEG2000 format:
sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
sudo apt install libjasper-dev
```

2. Get opencv and opencv_contrib git
```sh
git clone -b <version> --depth 1 https://github.com/opencv/opencv.git
```

or get a specific version of opencv at:

    https://opencv.org/releases/
    or
    https://github.com/opencv/opencv/tags

```sh
git clone -b <version> --depth 1 https://github.com/opencv/opencv_contrib.git
```

> **_NOTE:_** version of opencv & opencv_contrib MUST MATCH!!!

3. Activate venv & install numpy using pip (only when user wish to install using venv python)
```sh
pip install numpy Matplotlib IPython
```

4. Configure OpenCV with CMake
```sh
cd ~/opencv
# [optional] git checkout <version> (ex: 4.4.0)
mkdir build && cd build
cmake -D CMAKE_BUILD_TYPE=Release \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D WITH_CUDA=OFF \
    -D WITH_CUDNN=ON \
    -D OPENCV_DNN_CUDA=ON \
    -D ENABLE_FAST_MATH=1 \
    -D CUDA_FAST_MATH=1 \
    -D CUDA_ARCH_BIN=3.0 \
    -D WITH_CUBLAS=1 \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=<path to opencv_contrib dir>/modules \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D BUILD_EXAMPLES=OFF \
    -D BUILD_NEW_PYTHON_SUPPORT=ON \
    -D BUILD_opencv_python3=ON \
    -D HAVE_opencv_python3=ON \
    -D PYTHON2(3)_EXECUTABLE=<path to python> \
    -D PYTHON_INCLUDE_DIR=/usr/include/python<version> \
    -D PYTHON_INCLUDE_DIR2=/usr/include/x86_64-linux-gnu/python<version> \
    -D PYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython<version>.so \
    -D PYTHON2(3)_NUMPY_INCLUDE_DIRS=/usr/lib/python<version>/dist-packages/numpy/core/include/
    -D PYTHON_DEFAULT_EXECUTABLE=/usr/bin/python3 \
    -D PYTHON3_PACKAGES_PATH=<virtualenv dir>/lib/python3.6/site-packages/ \
    -D OPENCV_GENERATE_PKGCONFIG=ON \
    ..
```
    NOTE:   Edit `PYTHON_EXECUTABLE` depend on venv setup
            `CMAKE_INSTALL_PREFIX` may be unnecessary (default: /usr -> system scope | /usr/local -> user scope)
            `PYTHON_DEFAULT_EXECUTABLE` may be unnecessary
            `PYTHON(3)_EXECUTABLE` could be <virtualenv dir>/bin/python(3) or /usr/bin/python(3) depend on whether you use venv or not
            `CUDA_ARCH_BIN` must match your nvidia gpu arch - find here: https://developer.nvidia.com/cuda-gpus
            Use "cmake -LA" or use "ccmake ." to view & modify full options list
            Or remove CMakeCache.txt & re-run cmake
            Or manually edit CMakeCache.txt & CMakeVars.txt
      
Example for using python3 - local scope & system python (not venv):
```sh
cmake -D CMAKE_BUILD_TYPE=Release \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D WITH_CUDA=ON \
    -D WITH_CUDNN=ON \
    -D OPENCV_DNN_CUDA=ON \
    -D ENABLE_FAST_MATH=1 \
    -D CUDA_FAST_MATH=1 \
    -D CUDA_ARCH_BIN=3.0 \
    -D WITH_CUBLAS=1 \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=<path to opencv_contrib dir>/modules \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D BUILD_EXAMPLES=ON \
    -D BUILD_NEW_PYTHON_SUPPORT=ON \
    -D BUILD_opencv_python3=ON \
    -D HAVE_opencv_python3=ON \
    -D PYTHON_INCLUDE_DIR=/usr/include/python3.6 \
    -D PYTHON_INCLUDE_DIR2=/usr/include/x86_64-linux-gnu/python3.6m \
    -D PYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython3.6m.so \
    -D PYTHON3_NUMPY_INCLUDE_DIRS=/usr/local/lib/python3/dist-packages/numpy/core/include \
    -D PYTHON3_PACKAGES_PATH=$HOME/.local/lib/python3/site-packages \
    -D OPENCV_GENERATE_PKGCONFIG=ON \
    ..
```

For install cv2 to system scope python3, use `PYTHON3_PACKAGES_PATH=/usr/local/lib/python3/dist-packages`

5. Build opencv
```sh
make -j6 # j: # of parallel threads
```

6. Installing and verifying OpenCV
```sh
sudo make install
sudo ldconfig
```

7. Done

Test `import cv2` in python
or run cmd:
```sh
opencv_version
```

8. Uninstall
```sh
cd <path to opencv>/build
sudo make uninstall
```

Hotfix if `import cv2` failed:

Create symlink to cv2.cpython-36m-x86_64-linux-gnu.so
```sh
cd <virtualenv dir>/lib/python3.6/site-packages
ln -s /usr/local/lib/python3.6/site-packages/cv2/python-3.6/cv2.cpython-36m-x86_64-linux-gnu.so cv2.so
```

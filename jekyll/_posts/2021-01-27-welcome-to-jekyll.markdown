---
layout: post
title:  "How to create a virtual background in Ubuntu for Discord etc"
date:   2021-01-15 21:59:54 +0100
categories: discord
---
Due to the COVID19 situation, I recently had to teach a class via Discord. My new "office" is merely a desk in a kitchen, nothing glamorous. While I was teaching, I wanted to give my family the privacy to come and go so I decided to set up a virtual screen. However, Discord is not like Zoom, you cannot simply set up a virtual screen. 

I am running Ubuntu and needed a way to hide my background in Discord. You after reading a few blog posts, I decided to share what I learned. 

The first step is to procure a green screen. I purchased one relatively that was cheap on Alibaba. The second thing this to set up a virtual camera in Ubuntu. The trick is to capture the camera with the green screen and create a virtual camera that casts your image with the virtual background. Believe me, it is less painful than it sounds. The triggers to use two pieces of software, one that will create a virtual camera (v4l2loopback) and OBS studio which will take your camera, replace the green screen with a virtual background and broadcast to the virtual camera.

First, you need to install some software:
{% highlight bash %}
sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt install ffmpeg
sudo apt update

cd ~/Downloads/
git clone https://github.com/umlaeute/v4l2loopback.git
make
sudo make install
sudo depmod -a
sudo modprobe v4l2loopback
{% endhighlight %}

The last command installs the virtual camera. This command may fail. This can be the case if you're not logged in as a user with sudo rights or if you have secure boot.

We need a few modules to interface between OBS studio and v4l2loopback:
{% highlight bash %}
sudo apt install qtbase5-dev
sudo apt install libobs-dev

cd ~/Downloads/
git clone --recursive https://github.com/obsproject/obs-studio.git
git clone https://github.com/AndyHee/obs-v4l2sink.git

cd obs-v4l2sink
mkdir build && cd build

OBS_STUDIO_PROJECT_ROOT=$HOME/Download/obs-studio
OBS_V4L2SINK_PROJECT_ROOT=$HOME/Download/obs-v4l2sink
cmake -DLIBOBS_INCLUDE_DIR="$OBS_STUDIO_PROJECT_ROOT/libobs" -DCMAKE_INSTALL_PREFIX=/usr $OBS_V4L2SINK_PROJECT_ROOT
{% endhighlight %}

Finally, we will install OBS studio:
{% highlight bash %}
sudo apt install obs-studio
obs
{% endhighlight %}

Then, test the virtual camera: go to "Tools" and "V4L2 Video Output".
Then you need to set up the path to V4L2 Device. In my case, this is /dev/video2.

In sources, add Video Capture (this is your webcam). Also, add "Image" as a source and use it to set up the virtual image that you want.

Then we need to modify our webcam stream using "filters". We will set up the filters by selecting Video Capture and clicking "Filters". Three filters are important 1) "chroma key" is the actual filter that replaces the green for a virtual background, play with similarity until it works and we can still see your face. 2) "color correction" can correct minor color problems  3) "Crop/pad" is very useful if your green screen does not cover a patch of ceiling or something.

And there you go you have a virtual camera like those professional gamers!

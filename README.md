# dealRAW
This application include reading RAW file and process image from RAW

# 简介

此段代码目的有两个：
- 读取raw文件，并将图像信息分离出来
- 计算图像圆心位置并显示

## raw存储原理

raw是二进制信息存储文件，以我这次读取的文件为例，每个以8位1字节为单位，前180字节记录图像的各种参数（这次读取已被舍去），
往后依次是8幅图像数据，每个像素是12位，所以读取时我以16位为单位读取，之后处理时转为8位。

# 函数介绍




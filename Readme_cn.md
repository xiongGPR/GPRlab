<h1 align="center">
  <img src="https://raw.githubusercontent.com/erbiaoger/PicGo/main/20230404/202306061528806.jpg" alt="GPRlab" width="600">
      <br>GPRlab<br>
</h1>


<h4 align="center">探地雷达（GPR）数据分析和研究的开源免费软件.</h4>

<p align="center">
  <a href="https://github.com/xiongGPR/GPRlab/actions">
    <img src="https://img.shields.io/github/actions/workflow/status/xiongGPR/GPRlab/release.yml?branch=master&style=flat-square" alt="Github Actions">
  </a>
  <a href="https://goreportcard.com/report/github.com/xiongGPR/GPRlab">
    <img src="https://goreportcard.com/badge/github.com/xiongGPR/GPRlab?style=flat-square">
  </a>
  <img src="https://img.shields.io/github/go-mod/go-version/xiongGPR/GPRlab?style=flat-square">
  <a href="https://github.com/xiongGPR/GPRlab/releases">
    <img src="https://img.shields.io/github/release/xiongGPR/GPRlab/all.svg?style=flat-square">
  </a>
  <a href="https://github.com/xiongGPR/GPRlab/releases/tag/premium">
    <img src="https://img.shields.io/badge/release-Premium-00b4f0?style=flat-square">
  </a>
</p>
[English](https://github.com/xiongGPR/GPRlab/blob/main/README.md)  |  [中文](https://github.com/xiongGPR/GPRlab/blob/main/Readme_cn.md)

该软件是探地雷达（GPR）数据分析和研究的开源免费软件。软件可读取dzt，rd3，DT1等商业软件格式和矩阵排列的GPR数据，可保存处理流程和处理后的数据，并将数据传送至MATLAB的工作区。软件可显示雷达图和波形图，软件数据处理功能完备，具有去直流、去背景、信号增益、数学运算、一维滤波、二维滤波、波形分析等算法。软件中的图像中，具有保存图片，直接放大缩小图像，删除数据点，观测数据点，复制保存数据点等功能。


- [软件功能](#软件功能)
- [Installation](#installation)
  - [1. 在MATLAB中安装GPRlab](#1-在matlab中安装gprlab)
  - [2. 独立的桌面软件](#2-独立的桌面软件)
  - [3. GPRlab的卸载](#3-gprlab的卸载)
- [Usage](#usage)
  - [Case 1](#case-1)
  - [Case 2](#case-2)
- [Contributing](#contributing)
- [License](#license)


## 软件功能

如图2所示，GPRlab菜单的9个模块中提供了31种算法，涵盖了GPR数据处理中所有常用的方法。 这些算法将根据用户反馈和我们正在进行的研究进展进行修改或扩展。

![image-20230606150105747](https://raw.githubusercontent.com/erbiaoger/PicGo/main/20230404/202306062013495.jpg)

<center> Fig.2 Software functionalities

## Installation

我们推荐在MATLAB中安装APP的方式来安装本软件，尽管GPRlab也可以作为独立的桌面软件安装。

### 1. 在MATLAB中安装GPRlab

1. 首先确保您的电脑中安装有MATLAB R2020b及以上版本。

2. 如图 2‑1，打开MATLAB，进入APP模块，点击安装App，选择我们提供的GPRlab.mlappinstall.

3. 安装完成后，GPRlab就作为您MATLAB中的一个App (如图 2‑2)，点击即可使用。

![image-20230601150731047](https://raw.githubusercontent.com/erbiaoger/PicGo/main/20230404/202306062011123.bmp)

<center> 图 2‑1  MATLAB中安装GPRlab


![image-20230606202349587](https://raw.githubusercontent.com/erbiaoger/PicGo/main/20230404/202306062023722.png)

<center> 图 2‑2 MATLAB中已安装的GPRlab


### 2. 独立的桌面软件

如果您的电脑中已经有MATLAB R2020b及以上版本。您可以直接打开exe/for_redistribution_files_only文件夹.点击GPRlab.exe运行GPRlab，或者将GPRlab.exe发送快捷方式到您的电脑桌面。

如果您的电脑中没有MATLAB R2020b及以上版本。您可以使用exe/for_redistribution文件夹下的安装程序MyAppInstaller_mcr.exe安装 GPRlab.

**注意：我们建议您使用2.1节中的安装方式，独立的桌面软件是我们不推荐的选项，可能会遇到某些未知的问题。**

### 3. GPRlab的卸载

在MATLAB的APP模块中可以右键卸载。作为独立的桌面软件时，GPRlab的卸载方式和其它任何桌面软件相同。

## Usage

详见说明手册：[GPRlab 说明手册](https://github.com/xiongGPR/GPRlab/blob/main/docs/GPRlab%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C-%E4%B8%AD%E6%96%87.pdf)

### Case 1

在案例 1 中，我们从车载 GPR 系统获取数据，其任务是评估高速铁路隧道。 我们的目标是辨别隧道衬砌的内部结构完整性。 处理顺序一般可分为三个步骤。

1) 图 3a 说明了第一步。 使用数据模型模块，选择“加载”以输入“case1_raw_data.csv”数据文件并设置必要的参数。 单击“是”按钮确认您的设置。

2) 进入图像处理模块。 在这里，未处理的数据在图 3b 中可见。 但是，如果不进行进一步处理，很明显原始数据无法提供所需的结构信息。

3) 使用“加载处理”按钮导入“case1_Processing.csv”文件，或访问菜单设置以设置处理工作流（图 4c）。 通过单击“是”按钮，您确认您的操作并生成图 3d 中显示的处理结果。 如果需要返回原始数据，您可以使用“Reset_rawdata”按钮。

通过对比图 3a 和 3d，数据处理的效果变得明显。 先前隐藏的隧道衬砌内部结构出现，实现了我们处理步骤的目标。

![image-20230606145706692](https://raw.githubusercontent.com/erbiaoger/PicGo/main/20230404/202306062015981.svg)

<center> fig.3  Example of GPR data




### Case 2

案例2的数据是从位于月球背面南极冯卡门陨石坑的嫦娥四号探月雷达500MHz天线获取的。 我们的处理目标是获取月球表面附近的地下结构。 处理步骤分为三个步骤。

1) 图 4a 说明了第一步。 使用数据模型模块，选择“加载”以输入“case2_raw_data.csv”数据文件并设置必要的参数。 单击“是”按钮确认您的设置。

2) 进入图像处理模块。 在这里，未处理的数据在图 4b 中可见。 但是，如果不进行进一步处理，很明显原始数据无法提供所需的结构信息。

3) 使用“加载处理”按钮导入“case2_Processing.xlsx”文件，或访问菜单设置以设置处理工作流（图 4c）。 然后单击“是”按钮。 将调色板调整为“喷射”模式以获得图 4d 所示的处理结果。
   显然，图 4d 中使用 GPRlab 显示的处理结果揭示了月球背面 Von Kármán 陨石坑下方的近地表结构，而从图 4a 中显示的原始数据中无法观察到任何有意义的信息。

![image-20230606145931158](https://raw.githubusercontent.com/erbiaoger/PicGo/main/20230404/202306062017136.jpg)

<center> Fig.4 Example of lunar radar data

## Contributing

If you would like to contribute to My Awesome Project, please read the [contribution guidelines](tauri://localhost/CONTRIBUTING.md).

## License

My Awesome Project is licensed under the [GNU GENERAL PUBLIC LICENSE](https://github.com/xiongGPR/GPRlab/blob/main/LICENSE).






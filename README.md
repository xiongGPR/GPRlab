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

GPRlab is an open-source and free software for data analysis and research of ground-penetrating radar (GPR). The software can read commercial software formats such as dzt, rd3, DT1, and matrix-arranged GPR data, save processing steps and processed data, and transfer data to the MATLAB workspace. The software can display radar images and waveform graphs, and has complete data processing functions, including DC removal, background removal, signal gain, mathematical operations, one-dimensional filtering, two-dimensional filtering, waveform analysis, and other algorithms. The software's image has various functions such as saving images, directly zooming in and out of images, deleting data points, observing data points, and copying and saving data points.

- [Software Functions](#software-functions)
- [Installation](#installation)
  - [1. Installing GPRlab in MATLAB](#1-installing-gprlab-in-matlab)
  - [2. Standalone desktop software](#2-standalone-desktop-software)
  - [3. Uninstalling GPRlab](#3-uninstalling-gprlab)
- [Usage](#usage)
  - [Case 1](#case-1)
  - [Case 2](#case-2)
- [Contributing](#contributing)
- [License](#license)


## Software Functions

As shown in Figure 2, the nine modules in the GPRlab menu provide 31 algorithms covering all commonly used methods in GPR data processing. These algorithms will be modified or expanded based on user feedback and progress in our research.

![image-20230606150105747](https://raw.githubusercontent.com/erbiaoger/PicGo/main/20230404/202306062013495.jpg)

<h6 align="center">
<br>Fig.2 Software functionalities<br>
</h6>


## Installation

We recommend installing this software as an App in MATLAB, although GPRlab can also be installed as a standalone desktop software.

### 1. Installing GPRlab in MATLAB

- (1) First, make sure MATLAB R2020b or above is installed on your computer.

- (2) As shown in Figure 2-1, open MATLAB, enter the APP module, click "Install App", and select the GPRlab.mlappinstall we provide.

- (3) After installation, GPRlab will appear as an App in your MATLAB (as shown in Figure 2-2), click to use.

![image-20230601150731047](https://raw.githubusercontent.com/erbiaoger/PicGo/main/20230404/202306062011123.bmp)

<h6 align="center">
<br>Fig.2-1 Installing GPRlab in MATLAB<br>
</h6>

![image-20230606202349587](https://raw.githubusercontent.com/erbiaoger/PicGo/main/20230404/202306062023722.png)

<h6 align="center">
<br>Fig.2-2 GPRlab installed in MATLAB<br>
</h6>



### 2. Standalone desktop software

If your computer already has MATLAB R2020b or above installed, you can directly open the exe/for_redistribution_files_only folder, click GPRlab.exe to run GPRlab, or send a shortcut of GPRlab.exe to your computer desktop.

If your computer does not have MATLAB R2020b or above installed, you can use the installation program MyAppInstaller_mcr.exe in the exe/for_redistribution folder to install GPRlab.

**Note: We recommend using the installation method in section 1, the standalone desktop software is not our recommended option, and may encounter some unknown problems.**

### 3. Uninstalling GPRlab

You can right-click to uninstall GPRlab in the APP module of MATLAB. When GPRlab is used as standalone desktop software, it can be uninstalled in the same way as any other desktop software.

## Usage

Refer to the manual: [GPRlab User Manual](https://github.com/xiongGPR/GPRlab/blob/main/docs/GPRlab%20User%20Manual%20-English.pdf)

### Case 1

In Case 1, we obtained data from a vehicle-mounted GPR system, and the task is to evaluate the integrity of the internal structure of a high-speed railway tunnel. Our goal is to identify the internal structure integrity of the tunnel lining. The processing sequence is generally divided into three steps.

1) Figure 3a shows the first step. Use the data model module, select "Load" to input the "case1_raw_data.csv" data file and set the necessary parameters. Click the "Yes" button to confirm your settings.

2) Enter the image processing module. Here, the unprocessed data is visible in Figure 3b. However, it is obvious that the original data cannot provide the required structural information without further processing.

3) Use the "Load processing" button to import the "case1_Processing.csv" file, or access the menu settings to set the processing workflow (Figure 4c). By clicking the "Yes" button, you confirm your operation and generate the processing result displayed in Figure 3d. If you need to return to the original data, you can use the "Reset_rawdata" button.

By comparing Figure 3a and 3d, the effect of data processing becomes obvious. The internal structure of the tunnel lining that was previously hidden has appeared, achieving the goal of our processing steps.

![image-20230606145706692](https://raw.githubusercontent.com/erbiaoger/PicGo/main/20230404/202306062015981.svg)

<h6 align="center">
<br>Fig.3 Example of GPR data<br>
</h6>

### Case 2

The data of Case 2 was obtained from the 500MHz antenna of the Chang'e 4 lunar exploration radar located in the Von Kármán Crater in the South Pole of the Moon. Our processing goal is to obtain underground structures near the lunar surface. The processing steps are divided into three steps.

1) Figure 4a shows the first step. Use the data model module, select "Load" to input the "case2_raw_data.csv" data file and set the necessary parameters. Click the "Yes" button to confirm your settings.

2) Enter the image processing module. Here, the unprocessed data is visible in Figure 4b. However, it is obvious that the original data cannot provide the required structural information without further processing.

3) Use the "Load processing" button to import the "case2_Processing.xlsx" file, or access the menu settings to set the processing workflow (Figure 4c). Then click the "Yes" button. Adjust the palette to "jet" mode to obtain the processing result shown in Figure 4d.
   Obviously, the processing result displayed by GPRlab in Figure 4d reveals the near-surface structure below the Von Kármán crater on the back of the Moon, which cannot be observed from any meaningful information in the original data shown in Figure 4a.

![image-20230606145931158](https://raw.githubusercontent.com/erbiaoger/PicGo/main/20230404/202306062017136.jpg)

<h6 align="center">
<br>Fig.4 Example of lunar radar data<br>
</h6>

## Contributing

If you would like to contribute to My Awesome Project, please read the contribution guidelines.

## License

My Awesome Project is licensed under the [GNU GENERAL PUBLIC LICENSE](https://github.com/xiongGPR/GPRlab/blob/main/LICENSE).
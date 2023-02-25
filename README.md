# Exposure Fusion

## Basic Informations  
Description: An algorithm that uses one image and enhance it by obtaining its different exposure and combining it into one image  
Language: Matlab  
Features:
- Only require 1 image to do exposure fusion
- The image doesn't necessarily need to have a good exposure level
- Have done comparison on the amount of different exposure needed to create a good image
- All output will be directly saved into `Results` folder with its timestamp on the file name

## Code Flow
![code flow](./Images/flow.png)

## Example Inputs

Medium brightness input:  
![medium brightness input](./Images/C.jpg)  

Medium brightness input:  
![medium brightness input](./Images/Qcc9j.jpeg)  

Low brightness input:  
![low brightness input](./Images/3.png)  

Very low brightness input:  
![very low brightness input](./Images/low-light-photography-1-of-1-2.jpeg)  

Very low brightness input:  
![very low brightness input](./Images/n19qZ.jpeg)

## Example Outputs

Medium brightness output:  
![medium brightness input](./Results/exposureFusion_2022-12-24_T200839.jpg)  

Medium brightness output:  
![medium brightness input](./Results/exposureFusion_2022-12-24_T210437.jpg)  

Low brightness output:  
![low brightness input](./Results/exposureFusion_2022-12-24_T201419.jpg)  

Very low brightness output:  
![very low brightness input](./Results/exposureFusion_2022-12-24_T210915.jpg)  

Very low brightness output:  
![very low brightness input](./Results/exposureFusion_2023-01-15_T180353.jpg)

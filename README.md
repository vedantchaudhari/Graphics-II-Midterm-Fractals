# EGP-300 Graphics II Midterm: Fractals
### Team Members
    * Vedant Chaudhari  
      Contributions: Mandelbrot Fractal and Newton Fractal
    * Aaron Hamilton
      Contributions: Mengersponge Fractal
##### Repository Link: <https://github.com/vedantchaudhari/Graphics-Midterm-Fractal.git>
##### UML Link: <https://drive.google.com/file/d/1CDbDxGHCubsT0LwMnzMnEV2BGgdXEHPn/view?usp=sharing>
##### Use master branch, most recent commit  

***
## Project Description
For our midterm project we developed shaders for three fractals: **The Mandelbrot Fractal**, **The Newton Fractal** and **The Mengersponge Fractal** as immediate real-time effects. Our goal for the project was to make the Mandelbrot fractal and the Mengersponge interactive by allowing the user to increase or decrease the amount of iterations used by the algorithm. For the Newton fractal our goal was to use a Julia set and generate the fractal colors using a color ramp, then we use the generated fractal to texture models.  

**The Mengersponge Fractal** 
The Menger algorithm recursively divids each face of a cube into 9 squares. We have what is called the Mengersponge, which is the limit of this process after an infinite number of iterations. The Mengersponge will change with the viewport, taking into account distance and angle of the camera from the objects in the scene that have the Mengersponge effect on them. These 3D objects are the plane, a torus, a sphere and a cylinder.

![alt text](https://i.imgur.com/C7Y99tv.png "MengerSponge Fractal")
![alt text](https://i.imgur.com/WSWJ6fy.png?1 "Mandelbrot Fractal")
![alt text](https://i.imgur.com/GLaRPNt.png?1 "Newton Fractal")

Our Project fits into the fractal category because it generates three unique fractal effects, one as a 2D texture and the other two as textures for 3D models. Furthermore, two shaders have a controllable number of iterations and the other uses a color ramp. I think our added functionality meets the project requirements.

##### Pertinent Code
* drawJulia_fs4x.glsl
* drawMandlebrot_fs4x.glsl
* drawMenger_fs4x.glsl
* passJulia_vs4x.glsl
* passMandlebrotComponents_transform_vs4x.glsl
* passMenger_vs4x.glsl
* a3_DemoState.c
* a3_demo_callbacks.c
* a3_DemoState.h
* a3_DemoShaderProgram.h

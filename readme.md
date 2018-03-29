# EGP-300 Graphics II Midterm: Fractals
### Team Members
    * Vedant Chaudhari  
      Contributions: Mandelbrot Fractal and Newton Fractal
    * Aaron Hamilton
      Contributions:
##### Repository Link: <https://github.com/vedantchaudhari/Graphics-Midterm-Fractal.git>
##### Use master branch, most recent commit
***
## Project Description
For our midterm project we developed shaders for two fractals: **The Mandelbrot Fractal** & **The Newton Fractal** as immediate real-time effects. Our goal for the project was to make the Mandelbrot fractal interactive by allowing the user to increase or decrease the amount of iterations used by the algorithm. For the Newton fractal our goal was to use a Julia set and generate the fractal colors using a color ramp, then we use the generated fractal to texture models.
Our Project fits into the fractal category because it generates two unique fractal effects, one as a 2D texture and the other as textures for 3D models. Furthermore, one shader has a controllable number of iterations and the other uses a color ramp. I think our added functionality meets the project requirements.

##### Pertinent Code
* drawJulia_fs4x.glsl
* drawMandlebrot_fs4x.glsl
* passJulia_vs4x.glsl
* passMandlebrotComponents_transform_vs4x.glsl
* a3_DemoState.c
* a3_demo_callbacks.c
* a3_DemoState.h
* a3_DemoShaderProgram.h
* 
# -*- coding: mbcs -*-
#
# Abaqus/Viewer Release 2017 replay file
# Internal Version: 2016_09_28-05.54.59 126836
# Run by WangDoo on Tue Jul 09 22:43:48 2019
#

# from driverUtils import executeOnCaeGraphicsStartup
# executeOnCaeGraphicsStartup()
#: Executing "onCaeGraphicsStartup()" in the site directory ...
from abaqus import *
from abaqusConstants import *
session.Viewport(name='Viewport: 1', origin=(0.0, 0.0), width=324.539581298828, 
    height=184.481475830078)
session.viewports['Viewport: 1'].makeCurrent()
session.viewports['Viewport: 1'].maximize()
from viewerModules import *
from driverUtils import executeOnCaeStartup
executeOnCaeStartup()
o2 = session.openOdb(name='Job-obj-inp.odb')
#: Model: C:/Users/123/Desktop/inp-obj/Job-obj-inp.odb
#: Number of Assemblies:         1
#: Number of Assembly instances: 0
#: Number of Part instances:     1
#: Number of Meshes:             1
#: Number of Element Sets:       3
#: Number of Node Sets:          3
#: Number of Steps:              1
session.viewports['Viewport: 1'].setValues(displayedObject=o2)
session.viewports['Viewport: 1'].odbDisplay.display.setValues(plotState=(
    CONTOURS_ON_DEF, ))
session.viewports['Viewport: 1'].view.setValues(nearPlane=89.7296, 
    farPlane=154.329, width=82.0802, height=33.9307, cameraPosition=(71.0276, 
    92.5311, -43.5177), cameraUpVector=(-0.57625, -0.561023, -0.594297), 
    cameraTarget=(9.64243, 8.32847, 25.4147))
session.viewports['Viewport: 1'].view.setValues(nearPlane=87.9871, 
    farPlane=154.327, width=80.4862, height=33.2718, cameraPosition=(46.0056, 
    32.35, -91.0133), cameraUpVector=(-0.758396, -0.651792, -0.00170264), 
    cameraTarget=(10.2392, 9.76376, 26.5474))
session.viewports['Viewport: 1'].view.setValues(nearPlane=87.5557, 
    farPlane=154.903, width=80.0916, height=33.1087, cameraPosition=(68.147, 
    -29.5814, -76.247), cameraUpVector=(-0.665119, -0.6831, 0.301648), 
    cameraTarget=(9.54794, 11.6973, 26.0864))

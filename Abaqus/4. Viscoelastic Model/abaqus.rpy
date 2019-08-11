# -*- coding: mbcs -*-
#
# Abaqus/Viewer Release 2017 replay file
# Internal Version: 2016_09_28-05.54.59 126836
# Run by WangDoo on Wed Aug 07 16:00:42 2019
#

# from driverUtils import executeOnCaeGraphicsStartup
# executeOnCaeGraphicsStartup()
#: Executing "onCaeGraphicsStartup()" in the site directory ...
from abaqus import *
from abaqusConstants import *
session.Viewport(name='Viewport: 1', origin=(0.0, 0.0), width=286.278656005859, 
    height=163.320373535156)
session.viewports['Viewport: 1'].makeCurrent()
session.viewports['Viewport: 1'].maximize()
from viewerModules import *
from driverUtils import executeOnCaeStartup
executeOnCaeStartup()
o2 = session.openOdb(name='Job-Viscoelastic.odb')
#: Model: D:/Coding/Github/Fortarn/Abaqus/4. Viscoelastic Model/Job-Viscoelastic.odb
#: Number of Assemblies:         1
#: Number of Assembly instances: 0
#: Number of Part instances:     1
#: Number of Meshes:             1
#: Number of Element Sets:       4
#: Number of Node Sets:          4
#: Number of Steps:              1
session.viewports['Viewport: 1'].setValues(displayedObject=o2)
session.viewports['Viewport: 1'].odbDisplay.setPrimaryVariable(
    variableLabel='E', outputPosition=INTEGRATION_POINT, refinement=(INVARIANT, 
    'Max. Principal'), )
session.viewports['Viewport: 1'].odbDisplay.display.setValues(
    plotState=CONTOURS_ON_DEF)
session.viewports['Viewport: 1'].odbDisplay.setPrimaryVariable(
    variableLabel='E', outputPosition=INTEGRATION_POINT, refinement=(COMPONENT, 
    'E13'), )
session.viewports['Viewport: 1'].view.setValues(nearPlane=2.64925, 
    farPlane=4.66822, width=2.96703, height=1.2432, cameraPosition=(-0.0839486, 
    -0.491103, 4.011), cameraUpVector=(-0.17876, 0.976877, -0.117287), 
    cameraTarget=(0.511928, 0.447845, 0.525568))
session.viewports['Viewport: 1'].view.setValues(nearPlane=2.53072, 
    farPlane=4.79364, width=2.83429, height=1.18758, cameraPosition=(-1.61283, 
    -2.38189, 1.45488), cameraUpVector=(-0.200779, 0.777499, 0.595973), 
    cameraTarget=(0.511845, 0.447742, 0.525429))
session.viewports['Viewport: 1'].view.setValues(nearPlane=2.46465, 
    farPlane=4.72088, width=2.7603, height=1.15658, cameraPosition=(-2.5804, 
    1.7198, -0.967313), cameraUpVector=(-0.0347293, 0.119741, 0.992198), 
    cameraTarget=(0.510883, 0.451818, 0.523022))
session.viewports['Viewport: 1'].view.setValues(nearPlane=2.47132, 
    farPlane=4.77614, width=2.76778, height=1.15971, cameraPosition=(-1.3104, 
    -2.20714, -1.11573), cameraUpVector=(-0.373606, 0.141531, 0.916727), 
    cameraTarget=(0.487631, 0.523716, 0.525739))
session.viewports['Viewport: 1'].view.setValues(nearPlane=2.633, 
    farPlane=4.61478, width=2.94886, height=1.23558, cameraPosition=(-0.113581, 
    3.90529, -0.575572), cameraUpVector=(-0.356096, -0.120271, 0.926677), 
    cameraTarget=(0.476133, 0.464994, 0.52055))
session.viewports['Viewport: 1'].view.setValues(nearPlane=2.47812, 
    farPlane=4.78187, width=2.7754, height=1.1629, cameraPosition=(3.36062, 
    1.67178, 2.35442), cameraUpVector=(-0.803622, 0.0147349, 0.594957), 
    cameraTarget=(0.442913, 0.48635, 0.492534))
session.viewports['Viewport: 1'].view.setValues(nearPlane=2.65552, 
    farPlane=4.62436, width=2.97409, height=1.24615, cameraPosition=(3.95237, 
    0.104213, 1.438), cameraUpVector=(-0.541889, 0.203647, 0.815404), 
    cameraTarget=(0.43826, 0.498676, 0.49974))
session.viewports['Viewport: 1'].view.setValues(nearPlane=2.60496, 
    farPlane=4.66371, width=2.91746, height=1.22243, cameraPosition=(-0.274354, 
    -2.88882, 1.62435), cameraUpVector=(0.238349, 0.567625, 0.78803), 
    cameraTarget=(0.459849, 0.513964, 0.498788))
session.viewports['Viewport: 1'].view.setValues(nearPlane=2.49422, 
    farPlane=4.76702, width=2.79345, height=1.17046, cameraPosition=(-1.16863, 
    -2.4637, 1.86245), cameraUpVector=(0.372529, 0.54874, 0.748403), 
    cameraTarget=(0.465805, 0.511133, 0.497202))
session.viewports['Viewport: 1'].view.setValues(nearPlane=2.68079, 
    farPlane=4.5927, width=3.00241, height=1.25802, cameraPosition=(0.877473, 
    -2.998, 1.42758), cameraUpVector=(-0.195444, 0.539461, 0.819014), 
    cameraTarget=(0.450074, 0.515241, 0.500545))
odb = session.odbs['D:/Coding/Github/Fortarn/Abaqus/4. Viscoelastic Model/Job-Viscoelastic.odb']
session.xyDataListFromField(odb=odb, outputPosition=ELEMENT_CENTROID, 
    variable=(('E', INTEGRATION_POINT, ((COMPONENT, 'E13'), )), ('S', 
    INTEGRATION_POINT, ((COMPONENT, 'S13'), )), ), elementPick=(('PART-1-1', 1, 
    ('[#1 ]', )), ), )
xy1 = session.xyDataObjects['S:S13 PI: PART-1-1 E: 1 Centroid']
xy2 = session.xyDataObjects['E:E13 PI: PART-1-1 E: 1 Centroid']
xy3 = combine(xy1, xy2)
xyp = session.XYPlot('XYPlot-1')
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
c1 = session.Curve(xyData=xy3)
chart.setValues(curvesToPlot=(c1, ), )
session.viewports['Viewport: 1'].setValues(displayedObject=xyp)

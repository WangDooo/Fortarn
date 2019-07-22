# -*- coding: mbcs -*-
#
# Abaqus/Viewer Release 2017 replay file
# Internal Version: 2016_09_28-05.54.59 126836
# Run by WangDoo on Mon Jul 15 19:49:53 2019
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
o2 = session.openOdb(name='Job-Duncan.odb')
#: Model: D:/Coding/Github/Fortarn/Abaqus/3. Duncan Model/Job-Duncan.odb
#: Number of Assemblies:         1
#: Number of Assembly instances: 0
#: Number of Part instances:     1
#: Number of Meshes:             1
#: Number of Element Sets:       7
#: Number of Node Sets:          7
#: Number of Steps:              4
session.viewports['Viewport: 1'].setValues(displayedObject=o2)
session.viewports['Viewport: 1'].odbDisplay.display.setValues(plotState=(
    CONTOURS_ON_DEF, ))
session.viewports['Viewport: 1'].odbDisplay.setPrimaryVariable(
    variableLabel='E', outputPosition=INTEGRATION_POINT, refinement=(INVARIANT, 
    'Max. Principal'), )
session.viewports['Viewport: 1'].odbDisplay.setPrimaryVariable(
    variableLabel='E', outputPosition=INTEGRATION_POINT, refinement=(COMPONENT, 
    'E23'), )
session.viewports['Viewport: 1'].odbDisplay.setPrimaryVariable(
    variableLabel='E', outputPosition=INTEGRATION_POINT, refinement=(COMPONENT, 
    'E33'), )
session.viewports['Viewport: 1'].odbDisplay.setPrimaryVariable(
    variableLabel='E', outputPosition=INTEGRATION_POINT, refinement=(COMPONENT, 
    'E22'), )
session.viewports['Viewport: 1'].odbDisplay.setPrimaryVariable(
    variableLabel='E', outputPosition=INTEGRATION_POINT, refinement=(COMPONENT, 
    'E13'), )
session.viewports['Viewport: 1'].view.setValues(nearPlane=2.58805, 
    farPlane=4.76691, width=2.89849, height=1.21448, cameraPosition=(3.57357, 
    1.64701, 2.15166), cameraUpVector=(-0.471821, 0.770649, -0.428351), 
    cameraTarget=(0.523937, 0.455137, 0.519464))
session.viewports['Viewport: 1'].view.setValues(nearPlane=2.6645, 
    farPlane=4.74062, width=2.98412, height=1.25036, cameraPosition=(3.14851, 
    1.07195, 2.99379), cameraUpVector=(-0.233741, 0.856556, -0.460084), 
    cameraTarget=(0.521748, 0.452176, 0.523801))
session.viewports['Viewport: 1'].odbDisplay.setPrimaryVariable(
    variableLabel='E', outputPosition=INTEGRATION_POINT, refinement=(COMPONENT, 
    'E33'), )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step='geo', frame=1)
odb = session.odbs['D:/Coding/Github/Fortarn/Abaqus/3. Duncan Model/Job-Duncan.odb']
session.xyDataListFromField(odb=odb, outputPosition=ELEMENT_CENTROID, 
    variable=(('E', INTEGRATION_POINT, ((COMPONENT, 'E33'), )), ('S', 
    INTEGRATION_POINT, ((INVARIANT, 'Mises'), )), ), elementPick=(('PART-1-1', 
    1, ('[#1 ]', )), ), )
xyp = session.XYPlot('XYPlot-1')
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
xy1 = session.xyDataObjects['E:E33 PI: PART-1-1 E: 1 Centroid']
c1 = session.Curve(xyData=xy1)
chart.setValues(curvesToPlot=(c1, ), )
session.viewports['Viewport: 1'].setValues(displayedObject=xyp)
xy1 = session.xyDataObjects['E:E33 PI: PART-1-1 E: 1 Centroid']
xy2 = session.xyDataObjects['S:Mises PI: PART-1-1 E: 1 Centroid']
xy3 = combine(xy1, xy2)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
c1 = session.Curve(xyData=xy3)
chart.setValues(curvesToPlot=(c1, ), )
xy1 = session.xyDataObjects['E:E33 PI: PART-1-1 E: 1 Centroid']
xy2 = session.xyDataObjects['S:Mises PI: PART-1-1 E: 1 Centroid']
xy3 = combine(-xy1, xy2)
xyp = session.xyPlots['XYPlot-1']
chartName = xyp.charts.keys()[0]
chart = xyp.charts[chartName]
c1 = session.Curve(xyData=xy3)
chart.setValues(curvesToPlot=(c1, ), )

# -*- coding: mbcs -*-
#
# Abaqus/CAE Release 2017 replay file
# Internal Version: 2016_09_28-05.54.59 126836
# Run by WangDoo on Thu Aug 15 17:48:58 2019
#

# from driverUtils import executeOnCaeGraphicsStartup
# executeOnCaeGraphicsStartup()
#: Executing "onCaeGraphicsStartup()" in the site directory ...
from abaqus import *
from abaqusConstants import *
session.Viewport(name='Viewport: 1', origin=(0.0, 0.0), width=238.520309448242, 
    height=73.5212936401367)
session.viewports['Viewport: 1'].makeCurrent()
session.viewports['Viewport: 1'].maximize()
from caeModules import *
from driverUtils import executeOnCaeStartup
executeOnCaeStartup()
openMdb('E_soil_z.cae')
#: The model database "D:\Coding\Github\Fortarn\Abaqus\USDFLD\4. soil_E_z for\cae-2\E_soil_z.cae" has been opened.
session.viewports['Viewport: 1'].setValues(displayedObject=None)
session.viewports['Viewport: 1'].partDisplay.geometryOptions.setValues(
    referenceRepresentation=ON)
p = mdb.models['Model-1'].parts['Part-1']
session.viewports['Viewport: 1'].setValues(displayedObject=p)
a = mdb.models['Model-1'].rootAssembly
session.viewports['Viewport: 1'].setValues(displayedObject=a)
session.viewports['Viewport: 1'].assemblyDisplay.setValues(
    adaptiveMeshConstraints=ON, optimizationTasks=OFF, 
    geometricRestrictions=OFF, stopConditions=OFF)
mdb.models['Model-1'].StaticStep(name='Step-2', previous='Step-1')
session.viewports['Viewport: 1'].assemblyDisplay.setValues(step='Step-2')
session.viewports['Viewport: 1'].assemblyDisplay.setValues(loads=ON, bcs=ON, 
    predefinedFields=ON, connectors=ON, adaptiveMeshConstraints=OFF)
session.viewports['Viewport: 1'].assemblyDisplay.setValues(step='Step-1')
session.viewports['Viewport: 1'].view.setValues(nearPlane=255.753, 
    farPlane=356.964, width=289.476, height=121.291, cameraPosition=(42.889, 
    23.4872, 325.144), cameraUpVector=(-0.0495621, 0.964863, -0.258038), 
    cameraTarget=(52.7986, 48.296, 18.9053))
session.viewports['Viewport: 1'].view.setValues(nearPlane=230.266, 
    farPlane=384.963, width=260.628, height=109.204, cameraPosition=(59.9613, 
    -162.73, 241.997), cameraUpVector=(-0.200673, 0.895484, 0.39729), 
    cameraTarget=(52.7405, 48.9302, 19.1885))
a = mdb.models['Model-1'].rootAssembly
s1 = a.instances['Part-1-1'].faces
side1Faces1 = s1.getSequenceFromMask(mask=('[#10 ]', ), )
region = a.Surface(side1Faces=side1Faces1, name='Surf-1')
mdb.models['Model-1'].Pressure(name='Load-3', createStepName='Step-1', 
    region=region, distributionType=UNIFORM, field='', magnitude=-50.0, 
    amplitude=UNSET)
mdb.models['Model-1'].loads['Load-3'].setValues(magnitude=50.0)
mdb.models['Model-1'].loads['Load-3'].move('Step-1', 'Step-2')
session.viewports['Viewport: 1'].assemblyDisplay.setValues(loads=OFF, bcs=OFF, 
    predefinedFields=OFF, connectors=OFF)
mdb.jobs['Job-1'].submit(consistencyChecking=OFF)
#: The job input file "Job-1.inp" has been submitted for analysis.
#: Error in job Job-1: Problem during compilation - D:\Coding\Github\Fortarn\Abaqus\USDFLD\4. soil_E_z for\soil_E_z\E_z.for
#: Job Job-1 aborted due to errors.
mdb.jobs['Job-1'].submit(consistencyChecking=OFF)
#: The job input file "Job-1.inp" has been submitted for analysis.
#: Job Job-1: Analysis Input File Processor completed successfully.
#: ERROR in job messaging system: Error in connection to analysis
#: Error in job Job-1: The executable standard.exe aborted with system error code 1073741819. Please check the .dat, .msg, and .sta files for error messages if the files exist.  If there are no error messages and you cannot resolve the problem, please run the command "abaqus job=support information=support" to report and save your system information.  Use the same command to run Abaqus that you used when the problem occurred.  Please contact your local Abaqus support office and send them the input file, the file support.log which you just created, the executable name, and the error code.
#: Job Job-1 aborted due to errors.
session.viewports['Viewport: 1'].partDisplay.setValues(sectionAssignments=ON, 
    engineeringFeatures=ON)
session.viewports['Viewport: 1'].partDisplay.geometryOptions.setValues(
    referenceRepresentation=OFF)
p = mdb.models['Model-1'].parts['Part-1']
session.viewports['Viewport: 1'].setValues(displayedObject=p)
mdb.models['Model-1'].materials['MAT1'].Depvar(n=1)
a = mdb.models['Model-1'].rootAssembly
session.viewports['Viewport: 1'].setValues(displayedObject=a)
mdb.jobs['Job-1'].submit(consistencyChecking=OFF)
#: The job input file "Job-1.inp" has been submitted for analysis.
#: Job Job-1: Analysis Input File Processor completed successfully.
#: Job Job-1: Abaqus/Standard completed successfully.
#: Job Job-1 completed successfully. 
o3 = session.openOdb(
    name='D:/Coding/Github/Fortarn/Abaqus/USDFLD/4. soil_E_z for/cae-2/Job-1.odb')
#: Model: D:/Coding/Github/Fortarn/Abaqus/USDFLD/4. soil_E_z for/cae-2/Job-1.odb
#: Number of Assemblies:         1
#: Number of Assembly instances: 0
#: Number of Part instances:     1
#: Number of Meshes:             1
#: Number of Element Sets:       8
#: Number of Node Sets:          8
#: Number of Steps:              2
session.viewports['Viewport: 1'].setValues(displayedObject=o3)
session.viewports['Viewport: 1'].odbDisplay.setPrimaryVariable(
    variableLabel='FV1', outputPosition=INTEGRATION_POINT, )
session.viewports['Viewport: 1'].odbDisplay.display.setValues(
    plotState=CONTOURS_ON_DEF)
session.viewports['Viewport: 1'].view.setValues(nearPlane=219.67, 
    farPlane=409.048, width=248.635, height=104.179, cameraPosition=(200.905, 
    -194.292, 142.95), cameraUpVector=(-0.375318, 0.575228, 0.726807), 
    cameraTarget=(52.5254, 44.3879, 18.4082))
session.viewports['Viewport: 1'].view.setValues(nearPlane=237.674, 
    farPlane=391.085, width=269.014, height=112.718, cameraPosition=(44.8481, 
    -247.983, -85.0758), cameraUpVector=(-0.0976932, 0.0169219, 0.995073), 
    cameraTarget=(49.0716, 43.1996, 13.3616))
session.viewports['Viewport: 1'].view.setValues(nearPlane=238.019, 
    farPlane=391.063, width=269.405, height=112.882, cameraPosition=(54.1248, 
    -264.436, 7.91133), cameraUpVector=(-0.015002, 0.309991, 0.950621), 
    cameraTarget=(49.2775, 42.8344, 15.4259))
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=1, frame=0 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=1, frame=0 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=1, frame=1 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=1, frame=1 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=1, frame=1 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=1, frame=0 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=1, frame=0 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=1, frame=0 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=0, frame=6 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=0, frame=5 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=0, frame=4 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=0, frame=3 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=0, frame=2 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=0, frame=1 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=0, frame=0 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=0, frame=0 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=0, frame=1 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=0, frame=2 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=0, frame=3 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=0, frame=4 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=0, frame=5 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=0, frame=6 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=1, frame=0 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=1, frame=1 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=1, frame=1 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=1, frame=0 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=1, frame=1 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=1, frame=1 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=1, frame=1 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=1, frame=1 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=1, frame=1 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=1, frame=1 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=1, frame=1 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=1, frame=1 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=1, frame=1 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=1, frame=1 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=1, frame=1 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=1, frame=1 )
session.viewports['Viewport: 1'].odbDisplay.setFrame(step=1, frame=1 )
mdb.save()
#: The model database has been saved to "D:\Coding\Github\Fortarn\Abaqus\USDFLD\4. soil_E_z for\cae-2\E_soil_z.cae".

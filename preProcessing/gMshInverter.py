import gmsh
import array
import numpy as np

gmsh.initialize()
gmsh.open("/home/salaml/ablateInputs/geom/cylinder2D_xy_2cell.msh")
# gmsh.open("/home/salaml/ablateInputs/geom/CombustionChamberV4.msh")

# entities = gmsh.model.getEntities()
# for e in entities:
#     __, elementTags[e], __ = gmsh.model.mesh.getElements(e[0], e[1])
# print("The elementTags are: ", elementTags)
# nodeTags, nodeCoords, nodeParams = gmsh.model.mesh.getNodes()
# print("The nodeTags are: ", nodeTags)
# print("The nodeCoords are: ", nodeCoords)
# gmsh.model.mesh.reverse()

elementTypes, elementTags, nodeTags = gmsh.model.mesh.getElements()
print("The elementTypes are: ", elementTypes)
print("The elementTags are: ", elementTags)
print("The nodeTags are: ", nodeTags)

numElem = len(elementTags)
print("The number of elements is: ", numElem)

for l in range(len(elementTags)):
    for elementId in elementTags[l]:
        print("ElementId: ", elementId)
        # Get the element
        elementType, nodeTags, elementDim, elementTag = gmsh.model.mesh.getElement(
            elementId)  # elementType, nodeTags, dim, tag
        print("nodeTags: ", nodeTags)

        elementNodeCoords = []
        for k in range(len(nodeTags)):
            coord, parametricCoord, dim, tag = gmsh.model.mesh.getNode(nodeTags[k])
            # print("node: ", nodeTags[k], ' has coordinates: ', coord)
            elementNodeCoords.append(coord)
            # print("elementNodeCoords: ", elementNodeCoords)
            # print("for element node number", k, " coordinates are: ", elementNodeCoords[k])
            # np.cross(a,b)
        face1 = elementNodeCoords[1] - elementNodeCoords[0]
        face2 = elementNodeCoords[2] - elementNodeCoords[1]
        cross = np.cross(face1, face2)
        # print("face1:", face1)
        # print("face1:", face2)
        # print("cross product:", cross)

        # print("Norm: ", np.linalg.norm(cross))

        if cross[2] < 0:
            print("Element: ", elementId, "is inverted")
            newNodeTags = nodeTags[::-1]
            newNodeTags = np.append(newNodeTags[-1:], newNodeTags[:-1])
            print("reversed nodes", newNodeTags)

            gmsh.model.mesh.addElements(elementDim, elementTag, elementTypes, [[elementId + 2]], [newNodeTags])
            # gmsh.model.mesh.removeDuplicateElements()

# gmsh.model.mesh.renumberElements()
# gmsh.model.mesh.reorder_elements(2, 1, [1, 2, 3, 4])
# gmsh.model.mesh.removeDuplicateElements()
# gmsh.model.mesh.reverse()
print("\nChecking elements after inverting\n")
elementTypes, elementTags, nodeTags = gmsh.model.mesh.getElements()
print("The elementTypes are: ", elementTypes)
print("The elementTags are: ", elementTags)
print("The nodeTags are: ", nodeTags)

for l in range(len(elementTags)):
    for elementId in elementTags[l]:
        print("ElementId: ", elementId)
        # Get the element
        elementType, nodeTags, elementDim, elementTag = gmsh.model.mesh.getElement(
            elementId)  # elementType, nodeTags, dim, tag
        print("nodeTags: ", nodeTags)

        elementNodeCoords = []
        for k in range(len(nodeTags)):
            coord, parametricCoord, dim, tag = gmsh.model.mesh.getNode(nodeTags[k])
            # print("node: ", nodeTags[k], ' has coordinates: ', coord)
            elementNodeCoords.append(coord)
            # print("elementNodeCoords: ", elementNodeCoords)
            # print("for element node number", k, " coordinates are: ", elementNodeCoords[k])
            # np.cross(a,b)
        face1 = elementNodeCoords[1] - elementNodeCoords[0]
        face2 = elementNodeCoords[2] - elementNodeCoords[1]
        cross = np.cross(face1, face2)
        # print("face1:", face1)
        # print("face1:", face2)
        print("cross product:", cross)

        # print("Norm: ", np.linalg.norm(cross))

        if cross[2] < 0:
            print("Element: ", elementId, "is inverted")

# print("Size: ", np.size(elementTags))
# print(elementTags[0])
#
# numElem = sum(len(i) for i in elementTags)
# print(" - Mesh has " + str(len(nodeTags)) + " nodes and " + str(numElem) +
#       " elements")
#
# elementIds = (for i in elementTags)

# x = arr.array('i', [int(s) for s in elementTags] )
# print('The element in the index 3 of the array is: ', x[3])

# elementIds = [int(s) for s in elementTags]
# elementIds = list(map(int, elementTags))
# print("ElementIds: ", elementIds)
# Print the element information
# for elementId in float(elementTags):
#
#     print("Element: ", elementId)
#     # Get the element
#     element = gmsh.model.mesh.getElement(elementId)
# for elementTag in elementTags:
#
#     print("Element: ", elementTag)
#     # Get the element
#     element = gmsh.model.mesh.getElement(elementTag)


# Load in the element
# elementTypes, elementTags, nodeTags = gmsh.model.mesh.getElements()
# print("The elementTypes are: ", elementTypes)
# print("The elementTags are: ", elementTags)
# print("The nodeTags are: ", nodeTags)
#
# print("The dimTags are: ", gmsh.model.getPhysicalGroups())

# gmsh.model.mesh.setOutwardOrientation(0)
# dimTags = [2]
# gmsh.model.mesh.reverse()

# for tag in elementTags:
# gmsh.model.mesh.setReverse(2, tag, 0)
# gmsh.model.mesh.setReverse(2, 1, True)


# gmsh.model.mesh.recombine()
# for tag in elementTags:
#     print("tag: ", tag)
# gmsh.model.mesh.setOutwardOrientation(tag)

# elementTypes, elementTags, nodeTags = gmsh.model.mesh.getElements()
# print("The elementTypes are: ", elementTypes)
# print("The elementTags are: ", elementTags)
# print("The nodeTags are: ", nodeTags)
#
# gmsh.write("test_preProcessor_output.msh")

# elementIds = gmsh.model.mesh.getElementsByCoordinates(0.138613, 0.0175073, 0.00679931, 3, False)

# # Print the element information
# for elementId in elementIds:
#     print("Element: ", elementId)
#     # Get the element
#     element = gmsh.model.mesh.getElement(elementId)
#
#     avg = [0.0, 0.0, 0.0]
#     # Print the nodes
#     for n in element[1]:
#         avg[0] += gmsh.model.mesh.getNode(n)[0][0]/(len(element))
#         avg[1] += gmsh.model.mesh.getNode(n)[0][1]/(len(element))
#         avg[2] += gmsh.model.mesh.getNode(n)[0][2]/(len(element))
#         print("\t", str(gmsh.model.mesh.getNode(n)[0][0]), ", ", str(gmsh.model.mesh.getNode(n)[0][1]), ", ", str(gmsh.model.mesh.getNode(n)[0][2]))
#
#     print("\tavg:", str(avg[0]), ", ", str(avg[1]), ", ", str(avg[2]))
#     print("\tnodes: ", element[1])
#
#
#
# element = gmsh.model.mesh.getElement(2419)
#
# # get the element nodes
# nodes = element[1]
# print(nodes)
#
# # define the outward facing faces
# faces = [
#     [1, 2, 6, 5],
#     [0, 4, 7, 3],
#     [2, 3, 7, 6],
#     [1, 5, 4, 0],
#     [5, 6, 7, 4],
#     [0, 3, 2, 1]]
#
# # Compute the area on each face
# areas = [[]]
# areaMags = []
# centers = [[]]
# areasFromNorms = [[]]
# areasFromOrgs = [[]]
# areasFromOrgsMags = []
# norms = [[]]
# areaSum = [0, 0, 0]
# areaSumNorm = [0, 0, 0]
# centroid = [0, 0, 0]
#
# for n in nodes:
#     node = gmsh.model.mesh.getNode(n)
#     for d in range(3):
#         centroid[d] += node[0][d] / (len(nodes))
#
#
# def cross(a, b):
#     return [a[1]*b[2] - a[2]*b[1], a[2]*b[0] - a[0]*b[2], a[0]*b[1]-a[1]*b[0]]
#
# def norm(a):
#     mag = math.sqrt(a[0] * a[0] + a[1] * a[1] + a[2] * a[2])
#     return [a[0] / mag, a[1] / mag, a[2] / mag]
#
# for face in faces:
#     print("Face: ", face)
#     a = gmsh.model.mesh.getNode(nodes[face[0]])
#     b = gmsh.model.mesh.getNode(nodes[face[1]])
#     c = gmsh.model.mesh.getNode(nodes[face[2]])
#     ab = [b[0][0] - a[0][0], b[0][1] - a[0][1], b[0][2] - a[0][2]]
#     ac = [c[0][0] - a[0][0], c[0][1] - a[0][1], c[0][2] - a[0][2]]
#     area0 = cross(ab, ac)
#
#     # assume the norm is from first element
#     norm0 = norm(area0)
#     norms.append(norm0)
#
#     a = gmsh.model.mesh.getNode(nodes[face[0]])
#     b = gmsh.model.mesh.getNode(nodes[face[2]])
#     c = gmsh.model.mesh.getNode(nodes[face[3]])
#     ab = [b[0][0] - a[0][0], b[0][1] - a[0][1], b[0][2] - a[0][2]]
#     ac = [c[0][0] - a[0][0], c[0][1] - a[0][1], c[0][2] - a[0][2]]
#     area1 = cross(ab, ac)
#     area = ([0.5*(area1[0]+area0[0]), 0.5*(area1[1]+area0[1]), 0.5*(area1[2]+area0[2])])
#
#     areaSum[0] += area[0]
#     areaSum[1] += area[1]
#     areaSum[2] += area[2]
#     areas.append(area)
#     areaMag = math.sqrt(area[0]*area[0] + area[1]*area[1]+ area[2]*area[2])
#     areaMags.append(areaMag)
#
#     # Compute using the norm
#     areaNorm = [norm0[0]*areaMag, norm0[1]*areaMag, norm0[2]*areaMag]
#     areasFromNorms.append(areaNorm)
#     areaSumNorm[0] += areaNorm[0]
#     areaSumNorm[1] += areaNorm[1]
#     areaSumNorm[2] += areaNorm[2]
#
#     center = [0, 0, 0]
#     for n in face:
#         node = gmsh.model.mesh.getNode(nodes[n])
#         for d in range(3):
#             center[d] += node[0][d]/(len(face))
#
#     centers.append(center)
#
#     # Compute the area around summing each part
#     areaFromOrg = [0, 0, 0]
#     segments = [[0, 1], [1, 2], [2, 3], [3, 0]]
#     for segment in segments:
#         oA = gmsh.model.mesh.getNode(nodes[face[segment[0]]])[0]
#         oB = gmsh.model.mesh.getNode(nodes[face[segment[1]]])[0]
#         areaSegment = cross(oA, oB)
#         areaFromOrg[0] += areaSegment[0]
#         areaFromOrg[1] += areaSegment[1]
#         areaFromOrg[2] += areaSegment[2]
#
#     areasFromOrgs.append(areaFromOrg)
#     areasFromOrgsMags.append(math.sqrt(areaFromOrg[0]*areaFromOrg[0] + areaFromOrg[1]*areaFromOrg[1]+ areaFromOrg[2]*areaFromOrg[2]))
#
#
# print("areas: ", areas)
# print("centers: ", centers)
# print("areaSum: ", areaSum)
# print("areaMags: ", areaMags)
# print("areasFromOrgs: ", areasFromOrgs)
# print("areasFromOrgsMags: ", areasFromOrgsMags)
#
# print("areaSumNorm: ", areaSumNorm)
# print("centroid: " , centroid)


# for refrence:

# elementTypes, elementTags, nodeTags = gmsh.model.mesh.getElements()
# print("The elementTypes are: ", elementTypes)
# print("The elementTags are: ", elementTags)
# print("The nodeTags are: ", nodeTags)
# # print("len: ", len(elementTags))
#
# for l in range(len(elementTags)):
#     for elementId in elementTags[l]:
#         print("ElementId: ", elementId)
#         # Get the element
#         elementType, nodeTags, dim, tag = gmsh.model.mesh.getElement(elementId)  # elementType, nodeTags, dim, tag
#         print("nodeTags: ", nodeTags)
#
#         elementNodeCoords = []
#         for k in range(len(nodeTags)):
#             coord, parametricCoord, dim, tag = gmsh.model.mesh.getNode(nodeTags[k])
#             print("node: ", nodeTags[k], ' has coordinates: ', coord)
#             elementNodeCoords.append(coord)
#             print("elementNodeCoords: ", elementNodeCoords)
#             print("for element node number", k, " coordinates are: ", elementNodeCoords[k])
#             # np.cross(a,b)
#         face1 = elementNodeCoords[1]-elementNodeCoords[0]
#         face2 = elementNodeCoords[2]-elementNodeCoords[1]
#         cross = np.cross(face1, face2)
#         print("face1:", face1)
#         print("face1:", face2)
#         print("cross product:", cross)

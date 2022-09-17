import gmsh
import sys
import math

gmsh.initialize()
# gmsh.open("../geom/combustionChamber2dV04.1.msh")
gmsh.open("combustionChamber2dV04.4.bottom.msh")

elementTypes, elementTags, nodeTags = gmsh.model.mesh.getElements()
print("The elementTypes are: ", elementTypes)
print("The elementTags are: ", elementTags)
print("The nodeTags are: ", nodeTags)


# get the mesh data
m = {}
for e in gmsh.model.getEntities():
    bnd = gmsh.model.getBoundary([e])
    nod = gmsh.model.mesh.getNodes(e[0], e[1])
    ele = gmsh.model.mesh.getElements(e[0], e[1])
    m[e] = (bnd, nod, ele)

# transform the mesh and create new discrete entities to store it
def transform(m, offset_entity, offset_node, offset_element, tx, ty, tz):
    for e in sorted(m):
        gmsh.model.addDiscreteEntity(
            e[0], e[1] + offset_entity,
            [(abs(b[1]) + offset_entity) * math.copysign(1, b[1]) for b in m[e][0]])
        coord = []
        for i in range(0, len(m[e][1][1]), 3):
            x = m[e][1][1][i] * tx
            y = m[e][1][1][i + 1] * ty
            z = m[e][1][1][i + 2] * tz
            coord.append(x)
            coord.append(y)
            coord.append(z)
        gmsh.model.mesh.addNodes(e[0], e[1] + offset_entity, m[e][1][0] + offset_node, coord)
        gmsh.model.mesh.addElements(e[0], e[1] + offset_entity, m[e][2][0], [t + offset_element for t in m[e][2][1]], [n + offset_node for n in m[e][2][2]])
        if (tx * ty * tz) < 0: # reverse the orientation
            gmsh.model.mesh.reverse([(e[0], e[1] + offset_entity)])

transform(m, 500, 100000, 100000, 1, -1, 1)

# remove the duplicate nodes that will have been created on the internal
# boundaries
gmsh.model.mesh.removeDuplicateNodes()
gmsh.write('combustionChamber2dV04.4.mirrored.msh')


# if '-nopopup' not in sys.argv:
#     gmsh.fltk.run()

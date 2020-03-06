from Walk import Walk as Walk

from Graph import Graph as Graph
import sys
import random
sys.setrecursionlimit(1500)

def getHamiltonian(graph,start,end):
    print(graph.edges)
    visited=[]
    unvisited=[x for x in range(graph.totalV)]
    
    visited.append(start)
    adjacencies={}
    for elem in unvisited:
        acc=[]
        for index in range(len(graph.edges[elem])):
            if graph.edges[elem][index]==1:
              acc.append(index)
        if(len(acc)>0):
            adjacencies[elem]=acc
    print(adjacencies)
    


    def hamiltonianPath(walk, toVisit, unvisited, backFrom=None):

        if unvisited==[] and len(walk)==max(walk)+1:
            return walk
        
        if toVisit==[] and len(unvisited)>0:
            return None

        x= toVisit.pop(0)
        if x in unvisited:
            unvisited.remove(x)
        elif unvisited==[]:
            return walk
        else:
            #backtrack
            print(walk)
            return("Dead end")
        walk.append(x)
        for option in adjacencies[x]:
            if option in unvisited and option not in walk:
                toVisit.insert(0,option)
        return (hamiltonianPath(walk, toVisit,unvisited))


                
            
            


    return(hamiltonianPath([0],[1,2,3,5],[1,2,3,4,5]))




if __name__ == "__main__":

    graph = Graph.newRandomSimple(50,6,2)

    print(getHamiltonian(graph,0,3))

    
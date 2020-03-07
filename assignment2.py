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
        print("Walk: "+str(walk)+" toVisit: "+str(toVisit)+" unvisited: "+str(unvisited)+" backfrom: "+str(backFrom))

        #base case success
        if unvisited==[] and len(walk)==max(walk)+1:
            return walk
        #base case fail
        if toVisit==[] and len(unvisited)>0:
            return None
        

        #if the next vertex to travel to is connected, lets go there, else we have to backtrack
        if toVisit[0] in adjacencies[walk[len(walk)-1]]:
            x= toVisit.pop(0)
            if x==backFrom:
                toVisit.append(x)
                return (hamiltonianPath(walk,toVisit,unvisited))
        else:
            backFrom=walk.pop()
            toVisit.append(backFrom)
            unvisited.append(backFrom)
            print("Dead end, backtracking")
            return(hamiltonianPath(walk, toVisit,unvisited,backFrom))

        #if we havent been here yet, start looking for new paths
        if x in unvisited:
            unvisited.remove(x)
        #if this is the last vertex we are done
        elif unvisited==[]:
            return walk
        #if we have been here before, discard and check the next item in the toVisit list
        else:
            return(hamiltonianPath(walk, toVisit,unvisited,backFrom))
        walk.append(x)
        if x in toVisit:
            toVisit=list(filter(lambda a: a!=x,toVisit))
        for option in adjacencies[x]:
            if option in unvisited and option not in walk and option != backFrom:
                toVisit.insert(0,option)
        return (hamiltonianPath(walk, toVisit,unvisited))


                
            
            


    return(hamiltonianPath([0],[1,2,3,5],[1,2,3,4,5]))




if __name__ == "__main__":

    graph = Graph.newRandomSimple(50,6,2)

    print(getHamiltonian(graph,0,3))

    